import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThreadListContent extends StatelessWidget {
  final List<Map<String, dynamic>> threads;
  final String? currentThreadId;
  final Function(String)? onViewMessages;
  final VoidCallback? onClose;
  final bool isLoading;

  const ThreadListContent({
    Key? key,
    required this.threads,
    required this.isLoading,
    this.currentThreadId,
    this.onViewMessages,
    this.onClose,
  }) : super(key: key);

  String timeAgo(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final currentTime = DateTime.now();
      final createdAt = DateTime.parse(dateStr);
      final difference = currentTime.difference(createdAt);

      if (difference.inDays >= 7) {
        final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        return dateFormat.format(createdAt);
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chat History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (onClose != null)
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                )
            ],
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : threads.isEmpty
                    ? const Center(child: Text('No chat history'))
                    : ListView.separated(
                        itemCount: threads.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.blueGrey,
                          thickness: 0.5,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final thread = threads[index];
                          final isCurrentThread =
                              thread['openAiThreadId'] == currentThreadId;

                          return Card(
                            elevation: 0,
                            color: isCurrentThread
                                ? Colors.blueGrey.shade50
                                : Colors.white,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                if (onViewMessages != null) {
                                  onViewMessages!(thread['openAiThreadId']);
                                }
                              },
                              title: Row(
                                children: [
                                  if (isCurrentThread)
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 23, 37, 84),
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
                                  Flexible(
                                    child: Text(
                                      thread['threadName'] ??
                                          'Chat ${index + 1}',
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
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
