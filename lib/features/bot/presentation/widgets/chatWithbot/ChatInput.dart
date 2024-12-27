import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;

  const ChatInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Ask me anything...",
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      ),
      style: const TextStyle(
        fontSize: 14,
        height: 1.4,
      ),
      minLines: 1,
      maxLines: 4,
    );
  }
}
