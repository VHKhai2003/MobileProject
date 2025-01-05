import 'package:flutter/material.dart';

class ThreadListDialog extends StatelessWidget {
  final List<Map<String, dynamic>> threads;
  final String? currentThreadId;
  final Function(String)? onViewMessages;
  final bool isLoading;

  const ThreadListDialog({
    Key? key,
    required this.threads,
    required this.isLoading,
    this.currentThreadId,
    this.onViewMessages,
  }) : super(key: key);

  String timeAgo(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final currentTime = DateTime.now();
      final createdAt = DateTime.parse(dateStr);
      final difference = currentTime.difference(createdAt);

      if (difference.inDays >= 7) {
        return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chat History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : threads.isEmpty
                      ? const Center(child: Text('No chat history'))
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              threads.length,
                              (index) {
                                final thread = threads[index];
                                final isCurrentThread =
                                    thread['openAiThreadId'] == currentThreadId;

                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        onViewMessages
                                            ?.call(thread['openAiThreadId']);
                                      },
                                      child: Container(
                                        color: isCurrentThread
                                            ? Colors.blueGrey.shade50
                                            : Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      if (isCurrentThread)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 6,
                                                            vertical: 2,
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                23, 37, 84),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: const Text(
                                                            'current',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      Expanded(
                                                        child: Text(
                                                          thread['threadName'] ??
                                                              'Chat ${index + 1}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    timeAgo(
                                                        thread['createdAt']),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (index < threads.length - 1)
                                      const Divider(height: 1),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
