import 'package:code/features/chat/models/Assistant.dart';
import 'package:code/features/chat/models/Message.dart';
import 'package:code/features/chat/presentation/history/HistoryBottomSheet.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ChatProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/dialog/PromptSuggestionOverlay.dart';
import 'package:flutter/material.dart';
import 'package:code/features/chat/presentation/chatbox/AiModels.dart';
import 'package:code/features/prompt/presentation/PromptBottomSheet.dart';
import 'package:provider/provider.dart';

class Chatbox extends StatefulWidget {
  const Chatbox({super.key, required this.changeConversation, required this.openNewChat, required this.promptFocusNode, required this.isNewChat});

  final FocusNode promptFocusNode;
  final bool isNewChat;
  final VoidCallback changeConversation;
  final VoidCallback openNewChat;

  @override
  State<Chatbox> createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  final TextEditingController promptController = TextEditingController();
  OverlayEntry? _overlayEntry;

  void _onTextChanged(text) {
    if (text.endsWith('/')) {
      widget.promptFocusNode.unfocus();
      _overlayEntry = PromptSuggestionOverlay(context, _closeSuggestion, _handleUsePrompt).createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    } else if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _closeSuggestion() async {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
  void _handleUsePrompt(String? data) {
      if(data != null) {
        String currentStr = promptController.text;
        promptController.text = currentStr.substring(0, currentStr.length - 1) + data.toString();
      }
  }

  @override
  Widget build(BuildContext context) {
    final conversationProvider = Provider.of<ConversationsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final aiModelProvider = Provider.of<AiModelProvider>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AiModels(),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      // get conversation info here and display this conversation
                      widget.promptFocusNode.unfocus();
                      conversationProvider.getConversations(aiModelProvider.aiAgent.id);
                      String? result = await showModalBottomSheet(
                          context: context,
                          builder: (context) => HistoryBottomSheet(
                            conversationsProvider: conversationProvider,
                            aiModelProvider: aiModelProvider,
                          )
                      );
                      if(result == 'open') {
                        widget.changeConversation();
                      }
                    },
                    icon: const Icon(Icons.history, color: Colors.blueGrey,)
                ),
                IconButton(onPressed: () {
                  widget.promptFocusNode.unfocus();
                  conversationProvider.setSelectedIndex(-1);
                  widget.openNewChat();
                }, icon: Icon(Icons.add_comment_outlined, color: Colors.blue.shade700,)),
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
                controller: promptController,
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
                                          promptController.text = promptController.text + data.toString();
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
                        if (widget.isNewChat) {
                          conversationProvider.setConversationHistory(null);
                          conversationProvider.setConversations(null);
                          chatProvider.setMessages(
                            [
                              Column(
                                children: [
                                  chatProvider.buildQuestion(promptController.text),
                                  const SizedBox(height: 20),
                                  chatProvider.buildWaitForResponse(aiModelProvider.aiAgent),
                                  const SizedBox(height: 20),
                                ],
                              )
                            ]
                          );
                          chatProvider.setMessagesRequest(
                            [
                              Message(
                                  role: 'user',
                                  content: promptController.text,
                                  assistant: Assistant(
                                      id: aiModelProvider.aiAgent.id,
                                      model: 'dify',
                                      name: aiModelProvider.aiAgent.name
                                  )
                              )
                            ]
                          );
                          chatProvider.newThreadChat(aiModelProvider.aiAgent.id, promptController.text);
                          conversationProvider.setSelectedIndex(0);
                          widget.changeConversation();
                          promptController.clear();
                        } else {
                          chatProvider.addMessage(
                              Column(
                                children: [
                                  chatProvider.buildQuestion(promptController.text),
                                  const SizedBox(height: 20),
                                  chatProvider.buildWaitForResponse(aiModelProvider.aiAgent),
                                  const SizedBox(height: 20),
                                ],
                              )
                          );
                          chatProvider.sendMessage(
                              promptController.text,
                              chatProvider.conversationId!,
                              aiModelProvider.aiAgent
                          );
                          chatProvider.addMessageRequest(
                              Message(
                                  role: 'user',
                                  content: promptController.text,
                                  assistant: Assistant(
                                      id: aiModelProvider.aiAgent.id,
                                      model: 'dify',
                                      name: aiModelProvider.aiAgent.name
                                  )
                              )
                          );
                          promptController.clear();
                        }
                      },
                      icon: Icon(Icons.send, color: promptController.text == "" ? Colors.blueGrey : Colors.blue),)
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
