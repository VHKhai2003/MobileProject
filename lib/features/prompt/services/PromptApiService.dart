import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/prompt/models/Prompt.dart';
import 'package:dio/dio.dart';

class PromptApiService {
  static final PromptApiService _instance = PromptApiService._internal();

  late final ApiService _apiService;

  // private Constructor
  PromptApiService._internal() {
    _apiService = ApiService();
  }

  // Factory constructor
  factory PromptApiService() {
    return _instance;
  }


  Future<Map<String, dynamic>> getPrompts(Map<String, dynamic> params) async {
    final response = await _apiService.dio.get(
        ApiConstants.crudPrompts,
        queryParameters: params,
        options: Options(
            extra: {
              "requireToken": true,
            }
        )
    );
    return response.data;
  }

  // create prompt
  Future<bool> createPrompt(Prompt prompt) async {
    //call api
    try {
      await _apiService.dio.post(
        ApiConstants.crudPrompts,
        data: {
          "title": prompt.title,
          "content": prompt.content,
          "category": prompt.category,
          "description": prompt.description,
          "isPublic": prompt.isPublic,
          "language": "English",
        },
        options: Options(
          extra: {'requireToken': true,}
        )
      );
      // create success
      return true;
    }
    catch (e) {
      print('error when creating prompt: $e');
    }
    // create failed
    return false;
  }

  Future<bool> deletePrompt(Prompt prompt) async {
    //call api
    try {
      await _apiService.dio.delete(
          '${ApiConstants.crudPrompts}/${prompt.id}',
          options: Options(
              extra: {'requireToken': true,}
          )
      );
      // delete success
      return true;
    }
    catch (e) {
      print('error when delete prompt: $e');
    }
    // delete failed
    return false;
  }

  Future<bool> updatePrompt(Prompt prompt) async {
    try {
      await _apiService.dio.patch(
          '${ApiConstants.crudPrompts}/${prompt.id}',
          data: {
            "title": prompt.title,
            "content": prompt.content,
            "category": prompt.category,
            "description": prompt.description,
            "isPublic": prompt.isPublic,
            "language": "English",
          },
          options: Options(
              extra: {'requireToken': true,}
          )
      );
      // update success
      return true;
    }
    catch (e) {
      print('error when updating prompt: $e');
    }
    // update failed
    return false;
  }

  Future<bool> toggleFavorite(Prompt prompt) async {
    try {
      if(prompt.isFavorite) {
        // remove from favorite
        await _apiService.dio.post(
            '${ApiConstants.crudPrompts}/${prompt.id}/favorite',
            options: Options(
                extra: {'requireToken': true,}
            )
        );
      }
      else {
        // add to favorite
        await _apiService.dio.delete(
            '${ApiConstants.crudPrompts}/${prompt.id}/favorite',
            options: Options(
                extra: {'requireToken': true,}
            )
        );
      }

      // add success
      return true;
    }
    catch (e) {
      print('error when add to favorite: $e');
    }
    // add failed
    return false;
  }

}
