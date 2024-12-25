// import 'package:flutter/material.dart';
// import 'ChatBubble.dart';

// class ChatMessages extends StatelessWidget {
//   final ScrollController scrollController;
//   final List<Map<String, dynamic>> messages;
//   final bool isLoading;
//   final bool isBotTyping;
//   final String botName;

//   const ChatMessages({
//     Key? key,
//     required this.scrollController,
//     required this.messages,
//     this.isLoading = false,
//     required this.isBotTyping,
//     required this.botName,
//   }) : super(key: key);

//   Widget _buildTypingIndicator() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(Icons.android, size: 32.0, color: Colors.blue.shade700),
//           const SizedBox(width: 8),
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Colors.blue.shade100,
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildDot(1),
//                 _buildDot(2),
//                 _buildDot(3),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDot(int index) {
//     return TweenAnimationBuilder(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: 300 * index),
//       builder: (context, double value, child) {
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 2),
//           width: 6,
//           height: 6,
//           decoration: BoxDecoration(
//             color: Colors.blue.shade700.withOpacity(value),
//             shape: BoxShape.circle,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return ListView.builder(
//       controller: scrollController,
//       padding: const EdgeInsets.all(16.0),
//       itemCount: messages.length + (isBotTyping ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index < messages.length) {
//           final message = messages[index];
//           return ChatBubble(
//             isBot: message['isBot'] ?? false,
//             text: message['content'] ?? '',
//             threadId: message['threadId'],
//             timestamp: message['createdAt'],
//             botName: botName,
//           );
//         } else if (isBotTyping) {
//           return _buildTypingIndicator();
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'ChatBubble.dart';

class ChatMessages extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> messages;
  final bool isLoading;
  final bool isBotTyping;
  final String botName;

  const ChatMessages({
    Key? key,
    required this.scrollController,
    required this.messages,
    this.isLoading = false,
    required this.isBotTyping,
    required this.botName,
  }) : super(key: key);

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, bottom: 2.0),
            child: Text(
              botName,
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
                backgroundColor: Colors.blue[100],
                child: Image.asset(
                  'assets/icons/bot-icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.smart_toy,
                      size: 20,
                      color: Colors.blue[700],
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
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

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: messages.length + (isBotTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < messages.length) {
          final message = messages[index];
          return ChatBubble(
            isBot: message['isBot'] ?? false,
            text: message['content'] ?? '',
            threadId: message['threadId'],
            timestamp: message['createdAt'],
            botName: botName,
          );
        } else if (isBotTyping) {
          return _buildTypingIndicator();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
