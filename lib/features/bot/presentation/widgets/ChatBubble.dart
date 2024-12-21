import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;
  final String? threadId;
  final dynamic timestamp; // Thay đổi kiểu từ DateTime? sang dynamic

  const ChatBubble({
    Key? key,
    required this.isBot,
    required this.text,
    this.threadId,
    this.timestamp,
  }) : super(key: key);

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';

    DateTime dateTime;
    if (timestamp is String) {
      dateTime = DateTime.parse(timestamp);
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else {
      return '';
    }

    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

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
                    _formatTimestamp(timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: isBot ? TextAlign.left : TextAlign.right,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
