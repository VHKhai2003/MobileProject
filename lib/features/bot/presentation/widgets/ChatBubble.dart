import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;

  const ChatBubble({
    Key? key,
    required this.isBot,
    required this.text,
  }) : super(key: key);

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
              style: const TextStyle(fontSize: 16),
              textAlign: isBot ? TextAlign.left : TextAlign.right,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}
