import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/chat/models/AiAgent.dart';
import 'package:code/features/chat/models/Assistant.dart';
import 'package:code/features/chat/models/ConversationHistory.dart';
import 'package:code/features/chat/models/Conversations.dart';
import 'package:code/features/chat/models/Message.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ChatProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConversationsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final ChatProvider chatProvider;
  final AiModelProvider aiModelProvider;

  ConversationsProvider(this.chatProvider, this.aiModelProvider);

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

  void setConversationHistory(ConversationHistory? conversationHistory) {
    _conversationHistory = conversationHistory;
  }

  void setConversations(Conversations? conversations) {
    _conversations = conversations;
  }

  Future<void> getConversations(String assistantId) async {
    if (_conversations != null && _errorConversations == null) return;

    _isLoadingConversations = true;
    notifyListeners();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getConversations,
          queryParameters: {
            'assistantId': assistantId,
            'assistantModel': 'dify',
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

  Future<void> getConversationHistory(String conversationId, String assistantId) async {
    if (_conversationHistory?.id == conversationId && _errorConversationHistory == null) return;

    _isLoadingConversationHistory = true;
    notifyListeners();
    try {
      final response = await _apiService.dio.get(
          ApiConstants.getConversationHistory.replaceAll("{conversationId}", conversationId),
          queryParameters: {
            'assistantId': assistantId,
            'assistantModel': 'dify',
          },
          options: Options(
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _conversationHistory = ConversationHistory.fromJson(response.data, conversationId);
        if (_conversationHistory != null) {
          chatProvider.setConversationId(_conversationHistory!.id);
          chatProvider.setMessages(
              _conversationHistory!.items.map((message) {
                return Column(
                  children: [
                    chatProvider.buildQuestion(message.query),
                    const SizedBox(height: 20),
                    chatProvider.buildResponse(
                      AiAgent.findById(assistantId)!,
                      message.answer,
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList()
          );
          chatProvider.setMessagesRequest(
              _conversationHistory!.items.expand((message) {
                return [
                    Message(
                      role: 'user',
                      content: message.query,
                      assistant: Assistant(
                        id: aiModelProvider.aiAgent!.id,
                        model: 'dify',
                        name: aiModelProvider.aiAgent!.name
                      )
                    ),
                    Message(
                      role: 'model',
                      content: message.answer,
                      assistant: Assistant(
                        id: aiModelProvider.aiAgent!.id,
                        model: 'dify',
                        name: aiModelProvider.aiAgent!.name
                      )
                    )
                  ];
              }).toList()
          );
        }
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

  void createNewThreadChat(String content) {
    setConversationHistory(null);
    setConversations(null);
    chatProvider.setMessages(
        [
          Column(
            children: [
              chatProvider.buildQuestion(content),
              const SizedBox(height: 20),
              chatProvider.buildWaitForResponse(aiModelProvider.aiAgent!),
              const SizedBox(height: 20),
            ],
          )
        ]
    );
    chatProvider.setMessagesRequest(
        [
          Message(
              role: 'user',
              content: content,
              assistant: Assistant(
                  id: aiModelProvider.aiAgent!.id,
                  model: 'dify',
                  name: aiModelProvider.aiAgent!.name
              )
          )
        ]
    );
    chatProvider.newThreadChat(aiModelProvider.aiAgent!.id, content);
    setSelectedIndex(0);
  }

  void sendMessage(String content) {
    chatProvider.addMessage(
        Column(
          children: [
            chatProvider.buildQuestion(content),
            const SizedBox(height: 20),
            chatProvider.buildWaitForResponse(aiModelProvider.aiAgent!),
            const SizedBox(height: 20),
          ],
        )
    );
    chatProvider.sendMessage(
        content,
        chatProvider.conversationId!,
        aiModelProvider.aiAgent!
    );
    chatProvider.addMessageRequest(
        Message(
            role: 'user',
            content: content,
            assistant: Assistant(
                id: aiModelProvider.aiAgent!.id,
                model: 'dify',
                name: aiModelProvider.aiAgent!.name
            )
        )
    );
  }

}
