import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;

  const ChatInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Ask me anything, press '/' for prompts...",
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
