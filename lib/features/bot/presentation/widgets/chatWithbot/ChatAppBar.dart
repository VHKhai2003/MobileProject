import 'package:flutter/material.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String botName;
  final int tokenUsage;

  const ChatAppBar({
    super.key,
    required this.botName,
    required this.tokenUsage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEBEFFF),
      title: Row(
        children: [
          Image.asset(
            'assets/icons/bot-icon.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              botName,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
