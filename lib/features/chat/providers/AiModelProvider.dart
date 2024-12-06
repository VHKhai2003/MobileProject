import 'package:code/features/chat/models/AiAgent.dart';
import 'package:flutter/material.dart';

class AiModelProvider with ChangeNotifier {
  AiAgent _aiAgent = AiAgent.gpt_4o_mini;

  AiAgent get aiAgent => _aiAgent;

  void setAiAgent(AiAgent aiAgent) {
    _aiAgent = aiAgent;
    notifyListeners();
  }
}
