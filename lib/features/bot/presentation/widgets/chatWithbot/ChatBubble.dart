import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatBubble extends StatelessWidget {
  final bool isBot;
  final String text;
  final String? threadId;
  final dynamic timestamp;
  final String botName;

  const ChatBubble({
    super.key,
    required this.isBot,
    required this.text,
    required this.botName,
    this.threadId,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isTap = ValueNotifier(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  isBot ? botName : 'You',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 25),
              Flexible(
                child: ValueListenableBuilder<bool>(
                  valueListenable: isTap,
                  builder: (context, value, child) {
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      decoration: BoxDecoration(
                        color: value ? Colors.grey.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                      child: GestureDetector(
                        onTapDown: (_) {
                          isTap.value = true;
                        },
                        onTapUp: (_) {
                          isTap.value = false;
                        },
                        onTapCancel: () {
                          isTap.value = false;
                        },
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: text));
                          Fluttertoast.showToast(
                            msg: "Copied to clipboard!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
