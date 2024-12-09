import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/models/Unit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
        return true;
      }
    }
    catch(e) {
      print("Error when import from web");
    }
    return false;
  }
}
