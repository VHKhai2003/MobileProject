import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;
  final String? threadId;
  final dynamic timestamp;
  final String botName;

  const ChatBubble({
    Key? key,
    required this.isBot,
    required this.text,
    required this.botName,
    this.threadId,
    this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, bottom: 2.0),
            child: Text(
              isBot ? botName : 'You',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: isBot ? Colors.blue[100] : Colors.grey[200],
                child: Image.asset(
                  isBot ? 'assets/icons/bot-icon.png' : 'assets/icons/user.jpg',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      isBot ? Icons.smart_toy : Icons.person,
                      size: 20,
                      color: isBot ? Colors.blue[700] : Colors.grey[700],
                    );
                  },
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.85,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 0.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
