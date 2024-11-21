import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/data/models/TokenUsageModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenUsageProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  int _tokenUsage = 30;

  late TokenUsageModel _tokenUsageModel;

  int get tokenUsage => _tokenUsage;

  void setTokenUsage(int tokenUsage) {
    _tokenUsage = tokenUsage;
    notifyListeners();
  }

  Future<void> getUsage() async {
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getUsage,
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _tokenUsageModel = TokenUsageModel.fromJson(response.data);
        setTokenUsage(_tokenUsageModel.availableTokens);
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
