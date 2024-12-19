import 'package:flutter/material.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String botName;
  final String? threadId;
  final int tokenUsage;

  const ChatAppBar({
    Key? key,
    required this.botName,
    this.threadId,
    required this.tokenUsage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEBEFFF),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            botName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (threadId != null)
            Text(
              ' $threadId',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
        ],
      ),
      actions: buildActions(context, tokenUsage),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
