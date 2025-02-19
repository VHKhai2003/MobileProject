import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/core/utils/event_bus.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/data/models/CurrentUserModel.dart';
import 'package:code/data/models/TokenUsageModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenUsageProvider with ChangeNotifier {
  final ApiService _apiService;

  TokenUsageProvider(this._apiService) {
    setIsAuthenticated(_apiService.token != null);
    if (_apiService.token != null) {
      getUsage();
      getUser();
    }

    eventBus.on<TokenRefreshFailedEvent>().listen((event) {
      setIsAuthenticated(false);
    });
  }

  int _tokenUsage = 0;
  bool _isAuthenticated = false;

  late TokenUsageModel _tokenUsageModel = TokenUsageModel(availableTokens: 0, totalTokens: 0, unlimited: false, date: DateTime.now().toIso8601String());
  late CurrentUserModel _currentUserModel = CurrentUserModel(id: '', email: '', username: '');

  int get tokenUsage => _tokenUsage;
  bool get isAuthenticated => _isAuthenticated;
  TokenUsageModel get tokenUsageModel => _tokenUsageModel;
  CurrentUserModel get currentUserModel => _currentUserModel;

  void setTokenUsage(int tokenUsage) {
    _tokenUsage = tokenUsage;
    notifyListeners();
  }

  void setIsAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
  }

  Future<void> getUsage() async {
    await _apiService.loadTokens();
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
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
        } else {
          print("Error message: ${e.message}");
        }
      }
    }
  }

  Future<void> getUser() async {
    await _apiService.loadTokens();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getUser,
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _currentUserModel = CurrentUserModel.fromJson(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
        } else {
          print("Error message: ${e.message}");
        }
      }
    }
  }


  // test upgrade pro
  Future<void> getUsage1() async {
    await _apiService.loadTokens();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getUsage,
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _tokenUsageModel = TokenUsageModel.fromJson(response.data);
        _tokenUsageModel.unlimited = true;
        notifyListeners();
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Status code: ${e.response?.statusCode}");
          print("Response data: ${e.response?.data}");
        } else {
          print("Error message: ${e.message}");
        }
      }
    }
  }

}
