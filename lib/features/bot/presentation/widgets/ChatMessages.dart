import 'package:flutter/material.dart';
import 'ChatBubble.dart';

class ChatMessages extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> messages;
  final bool isLoading;
  final bool isBotTyping; // Thêm biến để kiểm tra bot đang trả lời

  const ChatMessages({
    Key? key,
    required this.scrollController,
    required this.messages,
    this.isLoading = false,
    required this.isBotTyping, // Thêm tham số này
  }) : super(key: key);

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.android, size: 32.0, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.shade100,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(1),
                _buildDot(2),
                _buildDot(3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 * index),
      builder: (context, double value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.blue.shade700.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Tạo một bản sao đảo ngược của messages
    final reversedMessages = messages.reversed.toList();

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: reversedMessages.length + (isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (isBotTyping && index == reversedMessages.length) {
          return _buildTypingIndicator();
        }
        final message = reversedMessages[index];
        return ChatBubble(
          isBot: message['isBot'] ?? false,
          text: message['content'] ?? '',
          threadId: message['threadId'],
          timestamp: message['timestamp'],
        );
      },
    );
  }
}
