// 2. chat_bubble.dart
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;
  final String? threadId; // giữ lại để không ảnh hưởng logic
  final DateTime? timestamp;

  const ChatBubble({
    Key? key,
    required this.isBot,
    required this.text,
    this.threadId,
    this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBot)
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4.0),
            child: Icon(Icons.android, size: 32.0, color: Colors.blue.shade700),
          ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isBot ? Colors.blue.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isBot ? Colors.blue.shade100 : Colors.green.shade100,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isBot ? Colors.black87 : Colors.black87,
                  ),
                  textAlign: isBot ? TextAlign.left : TextAlign.right,
                ),
                if (timestamp != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(timestamp!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
