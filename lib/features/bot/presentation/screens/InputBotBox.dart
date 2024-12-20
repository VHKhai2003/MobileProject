import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/bot/presentation/widgets/ListKbOnBot.dart';
import 'package:code/features/bot/presentation/widgets/InstructionInput.dart';
import 'package:code/features/bot/presentation/widgets/ChatInput.dart';
import 'package:code/features/bot/presentation/dialog/ThreadListDialog.dart';

class InputBotBox extends StatelessWidget {
  final VoidCallback changeConversation;
  final List<String> listKnownledge;
  final String botId;
  final TextEditingController instructionController;
  final TextEditingController chatController;
  final bool isUpdating;
  final bool showSuccess;
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
  });

  void showThreadListDialog(BuildContext context, List<dynamic> threads) {
    final List<Map<String, dynamic>> mappedThreads = threads.map((thread) {
      return Map<String, dynamic>.from(thread as Map);
    }).toList();

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                child: mappedThreads.isEmpty
                    ? const Center(child: Text('No chat history'))
                    : ListView.builder(
                        itemCount: mappedThreads.length,
                        itemBuilder: (context, index) {
                          final thread = mappedThreads[index];
                          return ListTile(
                            leading: const Icon(Icons.chat_bubble_outline),
                            title: Text(
                                thread['threadName'] ?? 'Chat ${index + 1}'),
                            subtitle: Text(
                              'Created: ${_formatDate(thread['createdAt'])}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              if (onViewMessages != null) {
                                onViewMessages!(thread['openAiThreadId']);
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade100),
                          ),
                          child: InstructionInput(
                            controller: instructionController,
                            onInstructionChange: onInstructionChange,
                            isUpdating: isUpdating,
                            showSuccess: showSuccess,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (onViewThreadList != null) {
                            await onViewThreadList!(botId);
                            if (context.mounted) {
                              final threads =
                                  threadProvider.threads.map((thread) {
                                return Map<String, dynamic>.from(thread as Map);
                              }).toList();

                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => ThreadListDialog(
                                    threads: threads,
                                    onThreadSelected: (threadId) {
                                      if (onViewMessages != null) {
                                        onViewMessages!(threadId);
                                      }
                                    },
                                  ),
                                );
                              }
                            }
                          }
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
              color: Colors.grey.shade50,
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
