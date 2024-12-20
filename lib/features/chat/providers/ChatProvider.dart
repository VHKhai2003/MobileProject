import 'dart:io';

import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/data/apis/ApiService.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/chat/models/AiAgent.dart';
import 'package:code/features/chat/models/Message.dart';
import 'package:code/features/chat/models/MessageResponse.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final TokenUsageProvider tokenUsageProvider;

  ChatProvider(this.tokenUsageProvider);

  List<Widget> _messages = [];
  String? _errorMessage;
  MessageResponse? _messageResponse;
  List<Message> _messagesRequest = [];
  String? _conversationId;
  String? _openAiThreadId;

  List<Widget> get messages => _messages;
  List<Message> get messagesRequest => _messagesRequest;
  String? get conversationId => _conversationId;
  String? get openAiThreadId => _openAiThreadId;

  Widget buildResponse(AiAgent agent, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            agent.image,
            width: 20, height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(agent.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(content),
            ],
          ),
        )
      ],
    );
  }

  Widget buildResponseBot(Bot bot, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            "assets/icons/android.png",
            width: 20, height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bot.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(content),
            ],
          ),
        )
      ],
    );
  }

  Widget buildWaitForResponse(AiAgent agent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            agent.image,
            width: 20, height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(agent.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitThreeBounce(
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildWaitForResponseBot(Bot bot) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            "assets/icons/android.png",
            width: 20, height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bot.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitThreeBounce(
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildQuestion(String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 10,
            backgroundColor: Colors.blue.shade700,
            child: Text(
              tokenUsageProvider.currentUserModel.username[0].toUpperCase(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            )
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("You", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(content)
            ],
          ),
        )
      ],
    );
  }

  void setConversationId(String id) {
    _conversationId = id;
  }

  void setOpenAiThreadId(String id) {
    _openAiThreadId = id;
  }

  void addMessage(Widget widget) {
    _messages.add(widget);
    notifyListeners();
  }

  void setMessages(List<Widget> widgets) {
    _messages = widgets;
    notifyListeners();
  }

  void printMessage() {
    for (var i in _messagesRequest) {
      print(i.toJson());
    }
  }

  void addMessageRequest(Message message) {
    _messagesRequest.add(message);
    notifyListeners();
  }

  void setMessagesRequest(List<Message> messages) {
    _messagesRequest = messages;
    notifyListeners();
  }

  Future<void> newThreadChat(String assistantId, String content) async {
    try {
      final response = await _apiService.dio.post(
          ApiConstants.newThreadChat,
          data: {
            "assistant": {
              "id": assistantId,
              "model": "dify"
            },
            "content": content
          },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _messageResponse = MessageResponse.fromJson(response.data);
        setConversationId(_messageResponse!.conversationId);
        _messages.removeLast();
        addMessage(
            Column(
              children: [
                buildQuestion(content),
                const SizedBox(height: 20),
                buildResponse(
                  AiAgent.findById(assistantId)!,
                  _messageResponse!.message
                ),
                const SizedBox(height: 20),
              ],
            )
        );

        tokenUsageProvider.setTokenUsage(_messageResponse!.remainingUsage);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to create new thread chat';
        _messageResponse = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _messageResponse = null;
      print(_errorMessage);
    }
  }

  Future<void> sendMessage(String content, String conversationId, AiAgent model) async {
    try {
      final response = await _apiService.dio.post(
          ApiConstants.sendMessage,
          data: {
            "content": content,
            "metadata": {
              "conversation": {
                "id": conversationId,
                "messages": _messagesRequest
              }
            },
            "assistant": {
              "id": model.id,
              "model": "dify",
              "name": model.name
            }
          },
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            extra: {'requireToken': true},
          )
      );
      if (response.statusCode == 200) {
        _messageResponse = MessageResponse.fromJson(response.data);
        print(response.data);
        _messages.removeLast();
        addMessage(
            Column(
              children: [
                buildQuestion(content),
                const SizedBox(height: 20),
                buildResponse(
                    AiAgent.findById(model.id)!,
                    _messageResponse!.message
                ),
                const SizedBox(height: 20),
              ],
            )
        );
        tokenUsageProvider.setTokenUsage(_messageResponse!.remainingUsage);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to send message';
        _messageResponse = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _messageResponse = null;
      print(_errorMessage);
    }
  }

}
