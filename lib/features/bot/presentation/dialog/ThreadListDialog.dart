// 1. thread_list_dialog.dart
import 'package:flutter/material.dart';

class ThreadListDialog extends StatelessWidget {
  final List<Map<String, dynamic>> threads;
  final Function(String threadId) onThreadSelected;

  const ThreadListDialog({
    Key? key,
    required this.threads,
    required this.onThreadSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chat History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: threads.isEmpty
                  ? const Center(child: Text('No chat history'))
                  : ListView.builder(
                      itemCount: threads.length,
                      itemBuilder: (context, index) {
                        final thread = threads[index];
                        return ListTile(
                          leading: const Icon(Icons.chat_bubble_outline),
                          title:
                              Text(thread['threadName'] ?? 'Chat ${index + 1}'),
                          subtitle: Text(
                            'Created: ${_formatDate(thread['createdAt'])}',
                            style: TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            onThreadSelected(thread['openAiThreadId']);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    final date = DateTime.parse(dateStr);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
