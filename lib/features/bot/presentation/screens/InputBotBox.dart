import 'package:code/features/bot/presentation/widgets/ListKbOnBot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';

class InputBotBox extends StatelessWidget {
  final VoidCallback changeConversation;
  final VoidCallback openNewChat;
  final List<String> listKnownledge;
  final String botId;
  final TextEditingController instructionController;
  final TextEditingController chatController;
  final bool isUpdating;
  final bool showSuccess;
  final ValueChanged<String> onInstructionChange;

  const InputBotBox({
    Key? key,
    required this.changeConversation,
    required this.openNewChat,
    required this.listKnownledge,
    required this.botId,
    required this.instructionController,
    required this.chatController,
    required this.isUpdating,
    required this.showSuccess,
    required this.onInstructionChange,
  }) : super(key: key);

  Widget _buildStatusIcon() {
    if (isUpdating) {
      return SizedBox(
        width: 12,
        height: 12,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blue.shade700,
        ),
      );
    } else if (showSuccess) {
      return Icon(
        Icons.check_circle,
        size: 12,
        color: Colors.green.shade600,
      );
    }
    return const SizedBox(width: 12);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            ListKbOnBot(
              listKnownledge: listKnownledge,
              botId: botId,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  SizedBox(
                    height: 32,
                    child: TextField(
                      controller: instructionController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
                        hintText: "Instructions...",
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      onChanged: onInstructionChange,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: _buildStatusIcon(),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                controller: chatController,
                decoration: const InputDecoration(
                  hintText: "Ask me anything, press '/' for prompts...",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 2, 2, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_comment_outlined,
                          color: Colors.blue.shade700),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
