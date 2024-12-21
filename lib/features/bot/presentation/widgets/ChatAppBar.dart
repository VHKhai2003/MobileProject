import 'package:flutter/material.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String botName;
  final int tokenUsage;

  const ChatAppBar({
    Key? key,
    required this.botName,
    required this.tokenUsage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEBEFFF),
      title: Expanded(
        child: Row(
          children: [
            Image.asset(
              'assets/icons/bot-icon.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              botName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: buildActions(context, tokenUsage),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
