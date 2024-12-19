import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';

class ChatController {
  final ThreadBotProvider threadProvider;
  final BotProvider botProvider;
  final String botId;
  final Function(bool) setLoading;
  final Function(String?) setThreadId;
  final Function(Bot?) setCurrentBot;
  final ScrollController scrollController;

  ChatController({
    required this.threadProvider,
    required this.botProvider,
    required this.botId,
    required this.setLoading,
    required this.setThreadId,
    required this.setCurrentBot,
    required this.scrollController,
  });

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> switchThread(String threadId) async {
    setLoading(true);
    try {
      setThreadId(threadId);
      await threadProvider.getThreadMessages(threadId);
      scrollToBottom();
    } catch (e) {
      print('Error switching thread: $e');
      // Xử lý lỗi ở UI
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadBotDetails() async {
    try {
      final bot = await botProvider.getBot(botId);
      setCurrentBot(bot);
    } catch (e) {
      print('Error loading bot details: $e');
      setCurrentBot(null);
    }
  }
}
