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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Padding(
            padding: EdgeInsets.only(bottom: 0.0),
            // left: isBot ? 36.0 : 36.0), // Added left padding for user name
            child: Text(
              isBot ? botName : 'You',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold, // Changed to bold
                color: Colors.grey[700],
              ),
            ),
          ),
          // Message row with avatar for both bot and user
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar for both bot and user
              CircleAvatar(
                radius: 16,
                backgroundColor: isBot ? Colors.blue[100] : Colors.grey[200],
                child: isBot
                    ? Icon(Icons.smart_toy, size: 20, color: Colors.blue[700])
                    : Icon(Icons.person, size: 20, color: Colors.grey[700]),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.85, // Increased width
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    // Removed border
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 0.0),
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
