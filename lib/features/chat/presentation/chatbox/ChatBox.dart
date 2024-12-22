import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/chat/presentation/history/BotHistoryBottomSheet.dart';
import 'package:code/features/chat/presentation/history/HistoryBottomSheet.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:code/features/prompt/presentation/dialog/PromptSuggestionOverlay.dart';
import 'package:flutter/material.dart';
import 'package:code/features/chat/presentation/chatbox/AiModels.dart';
import 'package:code/features/prompt/presentation/PromptBottomSheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Chatbox extends StatefulWidget {
  const Chatbox({super.key, required this.changeConversation, required this.openNewChat, required this.promptFocusNode, required this.isNewChat, required this.promptController, required this.scrollController});

  final FocusNode promptFocusNode;
  final TextEditingController promptController;
  final bool isNewChat;
  final VoidCallback changeConversation;
  final VoidCallback openNewChat;
  final ScrollController scrollController;

  @override
  State<Chatbox> createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  OverlayEntry? _overlayEntry;

  void _onTextChanged(text) {
    if (text.endsWith('/')) {
      widget.promptFocusNode.unfocus();
      _overlayEntry = PromptSuggestionOverlay(context, _closeSuggestion, _handleUsePrompt).createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else if (_overlayEntry != null) {
      setState(() {
        _overlayEntry!.remove();
        _overlayEntry = null;
      });
    }
  }

  void _closeSuggestion() async {
    if (_overlayEntry != null) {
      setState(() {
        _overlayEntry!.remove();
        _overlayEntry = null;
      });
    }
  }
  void _handleUsePrompt(String? data) {
    final conversationProvider = Provider.of<ConversationsProvider>(context);
    if(data != null) {
      final regex = RegExp(r'\[.*?\]');
      if (regex.hasMatch(data)) {
        widget.promptController.text = data.toString();
      } else {
        if (widget.isNewChat) {
          conversationProvider.createNewThreadChat(data);
          widget.changeConversation();
        } else {
          conversationProvider.sendMessage(data);
        }
        widget.promptController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final conversationProvider = Provider.of<ConversationsProvider>(context);
    final aiModelProvider = Provider.of<AiModelProvider>(context);
    final threadBotProvider = Provider.of<ThreadBotProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AiModels(openNewChat: widget.openNewChat),
            Row(
              children: [
                if (aiModelProvider.bot != null && aiModelProvider.aiAgent == null) ...[
                  IconButton(
                    onPressed: () async {
                      widget.promptFocusNode.unfocus();
                      threadBotProvider.getThreads(assistantId: aiModelProvider.bot!.id);
                      String? result = await showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                          BotHistoryBottomSheet(
                            conversationsProvider: conversationProvider,
                            threadBotProvider: threadBotProvider,
                            aiModelProvider: aiModelProvider,
                          )
                      );
                      if (result == 'open') {
                        widget.changeConversation();
                      }
                    },
                    icon: const Icon(Icons.history, color: Colors.blueGrey,),
                    tooltip: 'Chat History',
                  ),
                ] else if (aiModelProvider.bot == null && aiModelProvider.aiAgent != null) ...[
                  IconButton(
                    onPressed: () async {
                      // get conversation info here and display this conversation
                      if (aiModelProvider.aiAgent != null) {
                        widget.promptFocusNode.unfocus();
                        conversationProvider.getConversations(aiModelProvider.aiAgent!.id);
                        String? result = await showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                            HistoryBottomSheet(
                              conversationsProvider: conversationProvider,
                              aiModelProvider: aiModelProvider,
                            )
                        );
                        if (result == 'open') {
                          widget.changeConversation();
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Cannot get conversation history of assistant!',
                        );
                      }
                    },
                    icon: const Icon(Icons.history, color: Colors.blueGrey,),
                    tooltip: 'Chat History',
                  ),
                ],
                IconButton(
                  onPressed: () {
                    widget.promptFocusNode.unfocus();
                    conversationProvider.setSelectedIndex(-1);
                    widget.openNewChat();
                  },
                  icon: Icon(Icons.add_comment_outlined, color: Colors.blue.shade700,),
                  tooltip: 'New Chat',
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 6,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade800, width: 0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: _onTextChanged,
                controller: widget.promptController,
                focusNode: widget.promptFocusNode,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Ask me anything, press '/' for prompts...",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                )
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.promptFocusNode.unfocus();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Upload image'),
                                      onTap: () {
                                        // Handle upload image action
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Take photo'),
                                      onTap: () {
                                        // Handle take photo action
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.terminal),
                                      title: const Text('Prompt'),
                                      onTap: () async {
                                        String? data = await showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true, // lam cho chieu cao bottom sheet > 1/2 man hinh
                                            builder: (context) {
                                              return PromptBottomSheet();
                                            },
                                            barrierColor: Colors.black.withOpacity(0.2)
                                        );
                                        if(data != null) {
                                          final regex = RegExp(r'\[.*?\]');
                                          if (regex.hasMatch(data)) {
                                            widget.promptController.text = data.toString();
                                          } else {
                                            if (widget.isNewChat) {
                                              conversationProvider.createNewThreadChat(data);
                                              widget.changeConversation();
                                            } else {
                                              conversationProvider.sendMessage(data);
                                            }
                                          }
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              )
                            );
                          },
                          barrierColor: Colors.black.withOpacity(0.2)
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline, color: Colors.blueGrey),
                    ),
                    IconButton(
                      onPressed: () {
                        if (aiModelProvider.aiAgent != null && aiModelProvider.bot == null) {
                          if (widget.isNewChat) {
                            conversationProvider.createNewThreadChat(widget
                                .promptController.text);
                            widget.changeConversation();
                          } else {
                            conversationProvider.sendMessage(widget
                                .promptController.text);
                          }
                        } else if (aiModelProvider.bot != null && aiModelProvider.aiAgent == null) {
                          if (widget.isNewChat) {
                            conversationProvider.createNewThreadBot(aiModelProvider.bot!.id, widget.promptController.text);
                            widget.changeConversation();
                          } else {
                            conversationProvider.chatWithBot(aiModelProvider.bot!.id, widget.promptController.text, false);
                          }
                        }
                        widget.promptController.clear();
                      },
                      icon: Icon(Icons.send, color: widget.promptController.text == "" ? Colors.blueGrey : Colors.blue),)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
