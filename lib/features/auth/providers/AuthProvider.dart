import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final TokenUsageProvider _tokenUsageProvider;

  AuthProvider(this._tokenUsageProvider);

  Future<String?> login(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
          ApiConstants.login,
          data: {
            "email": email,
            "password": password
          }
      );
      if (response.statusCode == 200) {
        final accessToken = response.data['token']['accessToken'];
        final refreshToken = response.data['token']['refreshToken'];
        await _apiService.saveTokens(accessToken, refreshToken!);
        await _tokenUsageProvider.getUsage();
        return "success";
      }
      return "fail";
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
          return e.response?.data["details"][0]["issue"];
        } else {
          print("Error message: ${e.message}");
          return "Network error: ${e.message}";
        }
      }
      return "Unknown error: $e";
    }
  }

}
