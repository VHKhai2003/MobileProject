import 'package:flutter/material.dart';

class ChatActions extends StatelessWidget {
  final VoidCallback onNewChat;
  final VoidCallback onShowHistory;
  final VoidCallback onSendMessage;

  const ChatActions({
    Key? key,
    required this.onNewChat,
    required this.onShowHistory,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Two buttons above
        Row(
          children: [
            IconButton(
              onPressed: onShowHistory,
              icon: Icon(
                Icons.history,
                color: Colors.blue.shade700,
                size: 22,
              ),
              tooltip: 'Chat History',
              splashRadius: 20,
            ),
            IconButton(
              onPressed: onNewChat,
              icon: Icon(
                Icons.refresh,
                color: Colors.blue.shade700,
                size: 22,
              ),
              tooltip: 'New Chat',
              splashRadius: 20,
            ),
          ],
        ),
        // Send button inside chat area
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onSendMessage,
            icon: Icon(
              Icons.send_rounded,
              color: Colors.blue.shade700,
              size: 22,
            ),
            tooltip: 'Send Message',
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
