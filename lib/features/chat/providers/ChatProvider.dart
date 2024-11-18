import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Đăng nhập và lưu token
  Future<void> getConversations(String assistantId, String assistantModel) async {
    try {
      final response = await _apiService.dio.get(
        ApiConstants.getConversations,
        data: {
          'assistantId': assistantId,
          'assistantModel': assistantModel,
        },
        options: Options(
          extra: {'requireToken': true},
        )
      );
      if (response.statusCode == 200) {
        print(response.data);
        notifyListeners();
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  ApiService get apiService => _apiService;
}
