import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class ImportDataProvider with ChangeNotifier {

  final KBApiService _kbApiService = KBApiService();
  final Knowledge knowledge;

  ImportDataProvider({required this.knowledge});


  Future<bool> importWebsite(String name, String url) async {
    try {
      final response = await _kbApiService.dio.post(
          KBApiConstants.importWeb.replaceFirst("{id}", knowledge.id),
          data: {
            "unitName": name,
            "webUrl": url,
          },
          options: Options(
              extra: {
                "requireToken": true,
              }
          )
      );
      if(response.statusCode == 201 || response.statusCode == 200) {
        print(response.data);
        return true;
      }
    }
    catch(e) {
      print("Error when import from web");
    }
    return false;
  }

  MediaType _getContentType(String name) {
    if (name.endsWith('.txt')) {
      return MediaType('application', 'vnd.openxmlformats-officedocument.wordprocessingml.document');
    } else if (name.endsWith('.pdf')) {
      return MediaType('application', 'pdf');
    } else {
      return MediaType('text', 'plain');
    }
  }

  Future<bool> importFile(PlatformFile file) async {
    try {
      String name = file.name!;
      MultipartFile multipartFile;
      if (!kIsWeb) {
        // handle in mobile or desktop
        if (file.path == null) throw Exception('File path is null');
        multipartFile = await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
          contentType: _getContentType(name),
        );
      } else {
        // handle in web
        multipartFile = MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
          contentType: _getContentType(name),
        );
      }


      // create form data
      final formData = FormData.fromMap({
        'file': multipartFile,
      });

      // call api
      final response = await _kbApiService.dio.post(
          KBApiConstants.importFile.replaceFirst("{id}", knowledge.id),
          data: formData,
          options: Options(
              headers: {
                'Content-Type': 'multipart/form-data',
              },
              extra: {
                "requireToken": true,
              }
          )
      );
      if(response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
    }
    catch(e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
        } else {
          print("Error message: ${e.message}");
        }
      }
      print(e);
      print("Error when import from file");
    }

    return false;
  }
}
