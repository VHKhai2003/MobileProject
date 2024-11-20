import 'package:code/features/bot/presentation/screens/InputBotBox.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatWithBot extends StatelessWidget {
  final String botName;
  final List<String> listKnowledge;

  const ChatWithBot(
      {Key? key, required this.botName, required this.listKnowledge})
      : super(key: key);

  void changeConversation() {
    print("Conversation changed");
  }

  void openNewChat() {
    print("New chat opened");
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        title: Text(botName, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: buildActions(context, tokenUsageProvider.tokenUsage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(isBot: true, text: "Hi, Im $botName."),
                  ChatBubble(
                      isBot: false,
                      text:
                          "I need you help me do some thing .................")
                ],
              ),
            ),
            SizedBox(height: 10),
            InputBotBox(
              changeConversation: changeConversation,
              openNewChat: openNewChat,
              listKnownledge: listKnowledge,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;

  const ChatBubble({required this.isBot, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isBot)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.android, size: 32.0, color: Colors.blue),
          ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isBot ? Colors.blue.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
              textAlign: isBot ? TextAlign.left : TextAlign.right,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}
