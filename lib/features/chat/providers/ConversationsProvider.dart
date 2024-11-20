import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/chat/models/ConversationHistory.dart';
import 'package:code/features/chat/models/Conversations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConversationsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  Conversations? _conversations;
  bool _isLoadingConversations = false;
  bool _isLoadingConversationHistory = false;
  String? _errorConversations;
  String? _errorConversationHistory;
  int _selectedIndex = -1;
  ConversationHistory? _conversationHistory;

  Conversations? get conversations => _conversations;
  bool get isLoadingConversations => _isLoadingConversations;
  bool get isLoadingConversationHistory => _isLoadingConversationHistory;
  String? get errorConversations => _errorConversations;
  String? get errorConversationHistory => _errorConversationHistory;
  int get selectedIndex => _selectedIndex;
  ConversationHistory? get conversationHistory => _conversationHistory;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
  }

  Future<void> getConversations(String assistantId, String assistantModel) async {
    if (_conversations != null && _errorConversations == null) return;

    _isLoadingConversations = true;
    notifyListeners();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getConversations,
          queryParameters: {
            'assistantId': assistantId,
            'assistantModel': assistantModel,
          },
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _conversations = Conversations.fromJson(response.data);
        _errorConversations = null;
      } else {
        _errorConversations = 'Failed to fetch conversations';
        _conversations = null;
      }
    } catch (e) {
      _errorConversations = e.toString();
      _conversations = null;
    } finally {
      _isLoadingConversations = false;
      notifyListeners();
    }
  }

  Future<void> getConversationHistory(String conversationId, String assistantId, String assistantModel) async {
    if (_conversationHistory?.id == conversationId && _errorConversationHistory == null) return;

    _isLoadingConversationHistory = true;
    notifyListeners();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getConversationHistory.replaceAll("{conversationId}", conversationId),
          queryParameters: {
            'assistantId': assistantId,
            'assistantModel': assistantModel,
          },
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _conversationHistory = ConversationHistory.fromJson(response.data, conversationId);
        print(conversationId);
        print(response.data);
        print(_conversationHistory);
        _errorConversationHistory = null;
      } else {
        _errorConversationHistory = 'Failed to fetch conversation history';
        _conversationHistory = null;
      }
    } catch (e) {
      _errorConversationHistory = e.toString();
      _conversationHistory = null;
    } finally {
      _isLoadingConversationHistory = false;
      notifyListeners();
    }
  }
}
