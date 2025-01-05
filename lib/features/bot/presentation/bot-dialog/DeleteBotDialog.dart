import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';

class DeleteBotDialog extends StatefulWidget {
  const DeleteBotDialog({
    super.key,
    required this.botProvider,
    required this.bot,
  });

  final BotProvider botProvider;
  final Bot bot;

  @override
  State<DeleteBotDialog> createState() => _DeleteBotDialogState();
}

class _DeleteBotDialogState extends State<DeleteBotDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Delete Bot',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                const TextSpan(text: "Are you sure you want to delete "),
                TextSpan(
                  text: widget.bot.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This action cannot be undone.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            setState(() => isLoading = true);
            final success = await widget.botProvider.deleteBot(widget.bot.id);
            setState(() => isLoading = false);

            if (success) {
              widget.botProvider.clearListBot();
              widget.botProvider.loadBots('');
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Bot deleted successfully");
            } else {
              Fluttertoast.showToast(msg: "Failed to delete bot");
            }
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading) ...[
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              const Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}
