import 'package:flutter/material.dart';
import 'TimeAgo.dart';

class ThreadListTile extends StatelessWidget {
  final Map<String, dynamic> thread;
  final bool isCurrentThread;
  final VoidCallback onTap;

  const ThreadListTile({
    Key? key,
    required this.thread,
    required this.isCurrentThread,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: isCurrentThread ? Colors.blueGrey.shade50 : null,
      title: Row(
        children: [
          if (isCurrentThread)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 37, 84),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'current',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: Text(
              thread['threadName'] ?? 'Chat ${thread['index'] + 1}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Text(
        timeAgo(thread['createdAt']),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }
}
