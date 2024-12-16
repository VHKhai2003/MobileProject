// import 'package:code/features/bot/presentation/widgets/ListKbOnBot.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';

// class InputBotBox extends StatelessWidget {
//   final VoidCallback changeConversation;
//   final VoidCallback openNewChat;
//   final List<String> listKnownledge;
//   final String botId;
//   final TextEditingController instructionController;
//   final TextEditingController chatController;
//   final bool isUpdating;
//   final bool showSuccess;
//   final ValueChanged<String> onInstructionChange;

//   const InputBotBox({
//     Key? key,
//     required this.changeConversation,
//     required this.openNewChat,
//     required this.listKnownledge,
//     required this.botId,
//     required this.instructionController,
//     required this.chatController,
//     required this.isUpdating,
//     required this.showSuccess,
//     required this.onInstructionChange,
//   }) : super(key: key);

//   Widget _buildStatusIcon() {
//     if (isUpdating) {
//       return SizedBox(
//         width: 12,
//         height: 12,
//         child: CircularProgressIndicator(
//           strokeWidth: 2,
//           color: Colors.blue.shade700,
//         ),
//       );
//     } else if (showSuccess) {
//       return Icon(
//         Icons.check_circle,
//         size: 12,
//         color: Colors.green.shade600,
//       );
//     }
//     return const SizedBox(width: 12);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             ListKbOnBot(
//               listKnownledge: listKnownledge,
//               botId: botId,
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Stack(
//                 alignment: Alignment.centerRight,
//                 children: [
//                   SizedBox(
//                     height: 32,
//                     child: TextField(
//                       controller: instructionController,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         contentPadding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
//                         hintText: "Instructions...",
//                         hintStyle: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       style: const TextStyle(fontSize: 12),
//                       maxLines: 1,
//                       onChanged: onInstructionChange,
//                     ),
//                   ),
//                   Positioned(
//                     right: 8,
//                     child: _buildStatusIcon(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue.shade800, width: 0.6),
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: chatController,
//                 decoration: const InputDecoration(
//                   hintText: "Ask me anything, press '/' for prompts...",
//                   hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(4, 2, 2, 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.add_comment_outlined,
//                           color: Colors.blue.shade700),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.send, color: Colors.blueGrey),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextField(
                          controller: instructionController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 8, 32, 8),
                            hintText: "Instructions...",
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.3,
                          ),
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
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: chatController,
                  decoration: InputDecoration(
                    hintText: "Ask me anything, press '/' for prompts...",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                  minLines: 1,
                  maxLines: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.blue.shade50),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_comment_outlined,
                          color: Colors.blue.shade700,
                          size: 22,
                        ),
                        tooltip: 'Add comment',
                        splashRadius: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.blue.shade700,
                          size: 22,
                        ),
                        tooltip: 'Send message',
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
