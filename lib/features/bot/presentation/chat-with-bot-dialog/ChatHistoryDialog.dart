import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import '../widgets/commom/TimeAgo.dart';
import '../widgets/commom/ThreadListTitle.dart';

class ChatHistoryDialog extends StatelessWidget {
  final String? currentThreadId;
  final Function(String)? onViewMessages;

  const ChatHistoryDialog({
    Key? key,
    this.currentThreadId,
    this.onViewMessages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chat History',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Consumer<ThreadBotProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.threads.isEmpty) {
                      return const Center(child: Text('No chat history'));
                    }

                    final threads = provider.threads.map((thread) {
                      return Map<String, dynamic>.from(thread as Map);
                    }).toList();

                    return ListView.separated(
                      controller: controller,
                      itemCount: threads.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                      itemBuilder: (context, index) {
                        final thread = threads[index];
                        return ThreadListTile(
                          thread: thread,
                          isCurrentThread:
                              thread['openAiThreadId'] == currentThreadId,
                          onTap: () {
                            Navigator.pop(context);
                            onViewMessages?.call(thread['openAiThreadId']);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
