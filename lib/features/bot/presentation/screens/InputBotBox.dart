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
    Key? key,
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

  void showThreadListDialog(
      BuildContext context, List<dynamic> threads, String? currentThreadId) {
    final List<Map<String, dynamic>> mappedThreads = threads.map((thread) {
      return Map<String, dynamic>.from(thread as Map);
    }).toList();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
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
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close))
              ],
            ),
            Expanded(
              child: mappedThreads.isEmpty
                  ? const Center(child: Text('No chat history'))
                  : ListView.separated(
                      itemCount: mappedThreads.length,
                      itemBuilder: (context, index) {
                        final thread = mappedThreads[index];
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
                                      color:
                                          const Color.fromARGB(255, 23, 37, 84),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'current',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                Flexible(
                                  child: Text(
                                    thread['threadName'] ?? 'Chat ${index + 1}',
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
                                  color: Colors.grey, fontSize: 13),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.blueGrey,
                          thickness: 0.5,
                          height: 1,
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
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return '';
    }
  }

  Widget _buildStatusIcon() {
    if (isUpdating) {
      return Container(
        width: 16,
        height: 16,
        padding: const EdgeInsets.all(2),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blue.shade700,
        ),
      );
    } else if (showSuccess) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.check_circle,
          size: 14,
          color: Colors.green.shade600,
        ),
      );
    }
    return const SizedBox(width: 16);
  }

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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) {
                              // Sử dụng addPostFrameCallback để gọi API sau khi UI đã được build
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                onViewThreadList?.call(botId);
                              });

                              return Consumer<ThreadBotProvider>(
                                builder: (context, provider, _) {
                                  final threads =
                                      provider.threads.map((thread) {
                                    return Map<String, dynamic>.from(
                                        thread as Map);
                                  }).toList();

                                  return ThreadListContent(
                                    threads: threads,
                                    isLoading: provider.isLoading,
                                    currentThreadId: currentThreadId,
                                    onViewMessages: onViewMessages,
                                    onClose: () => Navigator.pop(context),
                                  );
                                },
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
