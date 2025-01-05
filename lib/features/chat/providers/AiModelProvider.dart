import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/chat/models/AiAgent.dart';
import 'package:flutter/material.dart';

class AiModelProvider with ChangeNotifier {
  AiAgent? _aiAgent = AiAgent.gpt_4o_mini;
  Bot? _bot;

  AiAgent? get aiAgent => _aiAgent;
  Bot? get bot => _bot;

  void setAiAgent(AiAgent? aiAgent) {
    _aiAgent = aiAgent;
    notifyListeners();
  }

  void setBot(Bot? bot) {
    _bot = bot;
    notifyListeners();
  }
}
