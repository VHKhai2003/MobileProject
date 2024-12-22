import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/bot/presentation/widgets/ListKbOnBot.dart';
import 'package:code/features/bot/presentation/widgets/InstructionInput.dart';
import 'package:code/features/bot/presentation/widgets/ChatInput.dart';
import 'package:intl/intl.dart';
import 'package:code/features/bot/presentation/widgets/ThreadListContent.dart';

class InputBotBox extends StatelessWidget {
  final VoidCallback changeConversation;
  final List<String> listKnownledge;
  final String botId;
  final TextEditingController instructionController;
  final TextEditingController chatController;
  final bool isUpdating;
  final bool showSuccess;
  final VoidCallback onCancelInstruction;
  final ValueChanged<String> onInstructionChange;
  final Function(String message, String threadId, String instruction)?
      onSendMessage;
  final Function(String assistantId, String message)? onCreateThread;
  final Function(String assistantId, String message)? onUpdateThread;
  final Function(String threadId)? onViewMessages;
  final Function(String assistantId)? onViewThreadList;
  final String? currentThreadId;

  const InputBotBox({
    super.key,
    required this.changeConversation,
    required this.listKnownledge,
    required this.botId,
    required this.instructionController,
    required this.chatController,
    required this.isUpdating,
    required this.showSuccess,
    required this.onInstructionChange,
    this.onSendMessage,
    this.onCreateThread,
    this.onUpdateThread,
    this.onViewMessages,
    this.onViewThreadList,
    this.currentThreadId,
    required this.onCancelInstruction,
  });
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

  void showThreadListDialog(
      BuildContext context, List<dynamic> threads, String? currentThreadId) {
    final List<Map<String, dynamic>> mappedThreads = threads.map((thread) {
      return Map<String, dynamic>.from(thread as Map);
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                          return const Center(
                              child: CircularProgressIndicator());
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
                            final isCurrentThread =
                                thread['openAiThreadId'] == currentThreadId;

                            return ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                if (onViewMessages != null) {
                                  onViewMessages!(thread['openAiThreadId']);
                                }
                              },
                              tileColor: isCurrentThread
                                  ? Colors.blueGrey.shade50
                                  : null,
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
                                  Expanded(
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
      },
    );

    // Call the API after showing the modal
    onViewThreadList?.call(botId);
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return '';
    }
  }

  // Widget _buildStatusIcon() {
  //   if (isUpdating) {
  //     return Container(
  //       width: 16,
  //       height: 16,
  //       padding: const EdgeInsets.all(2),
  //       child: CircularProgressIndicator(
  //         strokeWidth: 2,
  //         color: Colors.blue.shade700,
  //       ),
  //     );
  //   } else if (showSuccess) {
  //     return Container(
  //       decoration: BoxDecoration(
  //         color: Colors.green.shade50,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       padding: const EdgeInsets.all(2),
  //       child: Icon(
  //         Icons.check_circle,
  //         size: 14,
  //         color: Colors.green.shade600,
  //       ),
  //     );
  //   }
  //   return const SizedBox(width: 16);
  // }

  @override
  Widget build(BuildContext context) {
    final threadProvider = Provider.of<ThreadBotProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListKbOnBot(
                    listKnownledge: listKnownledge,
                    botId: botId,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InstructionInput(
                          controller: instructionController,
                          onInstructionChange: onInstructionChange,
                          isUpdating: isUpdating,
                          showSuccess: showSuccess,
                          onCancel: onCancelInstruction, // Thêm callback này
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              // Gọi API để lấy danh sách thread
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                onViewThreadList?.call(botId);
                              });

                              return Material(
                                color: Colors.transparent,
                                child: Consumer<ThreadBotProvider>(
                                  builder: (context, provider, _) {
                                    return ThreadListDialog(
                                      threads: provider.threads
                                          .map((thread) =>
                                              Map<String, dynamic>.from(
                                                  thread as Map))
                                          .toList(),
                                      isLoading: provider.isLoading,
                                      currentThreadId: currentThreadId,
                                      onViewMessages: onViewMessages,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.history,
                          color: Colors.blue.shade700,
                          size: 22,
                        ),
                        tooltip: 'Chat History',
                        splashRadius: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          changeConversation();
                          chatController.clear();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.blue.shade700,
                          size: 22,
                        ),
                        tooltip: 'New Chat',
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ChatInput(controller: chatController),
                ),
                IconButton(
                  onPressed: () {
                    if (chatController.text.isEmpty) return;
                    if (onSendMessage != null) {
                      onSendMessage!(
                        chatController.text,
                        currentThreadId ?? '',
                        instructionController.text,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    color: Colors.blue.shade700,
                    size: 22,
                  ),
                  tooltip: 'Send Message',
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
