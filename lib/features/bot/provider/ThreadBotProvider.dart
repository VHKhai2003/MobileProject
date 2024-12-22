import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:code/core/constants/KBApiConstants.dart';
import 'package:code/data/apis/KBApiService.dart';

class ThreadBotProvider with ChangeNotifier {
  final KBApiService _kbApiService = KBApiService();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  List<dynamic> threads = [];
  bool hasNext = false;
  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
  }

  Future<String?> createThread({
    required String assistantId,
    String? firstMessage,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.post(
        KBApiConstants.createThreadBot,
        data: {
          'assistantId': assistantId,
          if (firstMessage != null && firstMessage.isNotEmpty)
            'firstMessage': firstMessage,
        },
        options: Options(
          headers: {'x-jarvis-guid': null},
          extra: {"requireToken": true},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Thay đổi từ threadId thành openAiThreadId
        final threadId = response.data['openAiThreadId'];
        return threadId;
      }
      return null;
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateThreadPlayground({
    required String assistantId,
    String? firstMessage,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.post(
        KBApiConstants.updateNewThread,
        data: {
          'assistantId': assistantId,
          if (firstMessage != null && firstMessage.isNotEmpty)
            'firstMessage': firstMessage,
        },
        options: Options(
          headers: {
            'x-jarvis-guid': null,
          },
          extra: {"requireToken": true},
        ),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> askAssistant(
    String assistantId, {
    required String message,
    required String threadId,
    String? additionalInstruction,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.post(
        KBApiConstants.askBot.replaceAll('{assistantId}', assistantId),
        data: {
          'message': message,
          'openAiThreadId': threadId,
          'additionalInstruction': additionalInstruction ?? '',
        },
        options: Options(
          headers: {'x-jarvis-guid': null},
          extra: {"requireToken": true},
        ),
      );

      String? botResponse;
      if (response.data is String) {
        botResponse = response.data;
      } else if (response.data is Map && response.data['response'] != null) {
        botResponse = response.data['response'].toString();
      }

      return botResponse;
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getThreadMessages(String threadId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.get(
        KBApiConstants.retrieveMess.replaceAll('{openAiThreadId}', threadId),
        options: Options(
          headers: {'x-jarvis-guid': null},
          extra: {"requireToken": true},
        ),
      );

      if (response.data != null && response.data is List) {
        messages = (response.data as List).map<Map<String, dynamic>>((msg) {
          String messageContent = '';

          if (msg['content'] is List) {
            for (var content in msg['content']) {
              if (content['type'] == 'text' &&
                  content['text'] != null &&
                  content['text']['value'] != null) {
                messageContent = content['text']['value'];
                break;
              }
            }
          } else {
            messageContent = msg['content']?.toString() ?? '';
          }

          return {
            'content': messageContent,
            'isBot': msg['role'] == 'assistant',
            'timestamp': DateTime.fromMillisecondsSinceEpoch(
                (msg['createdAt'] ?? DateTime.now().millisecondsSinceEpoch) *
                    1000),
            'threadId': threadId,
          };
        }).toList();

        messages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        notifyListeners();
      }
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      messages = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getThreads({
    required String assistantId,
    String? query,
    String order = 'DESC',
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _kbApiService.dio.get(
        KBApiConstants.getThead.replaceAll('{assistantId}', assistantId),
        queryParameters: {
          if (query != null && query.isNotEmpty) 'q': query,
          'order': order,
          if (orderField != null && orderField.isNotEmpty)
            'order_field': orderField,
          'offset': offset,
          'limit': limit.clamp(1, 50),
        },
        options: Options(
          headers: {
            'x-jarvis-guid': null,
          },
          extra: {"requireToken": true},
        ),
      );
      if (response.data != null && response.data['data'] is List) {
        if (offset == 0) {
          threads.clear();
        }
        threads.addAll(response.data['data']);
        hasNext = response.data['meta']?['hasNext'] ?? false;
        notifyListeners();
      }
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addMessage({
    required String content,
    required bool isBot,
    String? threadId,
  }) {
    final message = <String, dynamic>{
      'content': content,
      'isBot': isBot,
      'timestamp': DateTime.now(),
      'threadId': threadId,
    };

    messages.add(message);
    notifyListeners();
  }

  void clearThreads() {
    threads.clear();
    hasNext = false;
    notifyListeners();
  }

  void clearMessages() {
    messages.clear();
    notifyListeners();
  }
}
