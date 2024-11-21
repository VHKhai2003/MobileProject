import 'package:code/features/chat/models/ChatHistoryInfo.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoryBottomSheet extends StatefulWidget {
  const HistoryBottomSheet({super.key, required this.conversationsProvider, required this.aiModelProvider});
  final ConversationsProvider conversationsProvider;
  final AiModelProvider aiModelProvider;
  @override
  State<HistoryBottomSheet> createState() => _HistoryBottomSheetState();
}

class _HistoryBottomSheetState extends State<HistoryBottomSheet> {
  String timeAgo(int timestamp) {
    final currentTime = DateTime.now();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: widget.conversationsProvider),
        ChangeNotifierProvider.value(value: widget.aiModelProvider)
      ],
      child: Consumer2<ConversationsProvider, AiModelProvider>(
        builder: (context, conversationsProvider, aiModelProvider, child) {
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('History', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    IconButton(onPressed: () {
                      Navigator.of(context).pop("close");
                    }, icon: const Icon(Icons.close))
                  ],
                ),
                if (conversationsProvider.isLoadingConversations) ...[
                  Expanded(child: Center(child: CircularProgressIndicator()))
                ] else if (conversationsProvider.errorConversations != null) ...[
                  Expanded(child: Center(child: Text('Error: ${conversationsProvider.errorConversations}')))
                ] else if (conversationsProvider.conversations == null) ...[
                  Expanded(child: Center(child: Text('No conversations found.')))
                ] else ...[
                  Expanded(
                    child: ListView.separated(
                      itemCount: conversationsProvider.conversations!.items.length,
                      itemBuilder: (context, index) {
                        ChatHistoryInfo chatHistoryInfo = conversationsProvider.conversations!.items[index];
                        return Card(
                          elevation: 0,
                          color: index == conversationsProvider.selectedIndex ? Colors.blueGrey
                              .shade50 : Colors.white,
                          child: ListTile(
                            onTap: () {
                              conversationsProvider.setSelectedIndex(index);
                              conversationsProvider.getConversationHistory(chatHistoryInfo.id, aiModelProvider.aiAgent.id);
                              Navigator.of(context).pop("open");
                            },
                            title: Row(
                              children: [
                                index == conversationsProvider.selectedIndex ? Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      6, 2, 6, 2),
                                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 23, 37, 84),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('current', style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),),
                                ) : const SizedBox.shrink(),
                                Flexible(
                                  child: Text(
                                    chatHistoryInfo.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              timeAgo(chatHistoryInfo.createdAt),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
