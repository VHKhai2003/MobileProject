import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/presentation/screens/InputBotBox.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'dart:async';
import 'package:code/features/bot/presentation/widgets/ChatBubble.dart';

class ChatWithBot extends StatefulWidget {
  final BotProvider botProvider;
  final Bot bot;

  const ChatWithBot({
    Key? key,
    required this.bot,
    required this.botProvider,
  }) : super(key: key);

  @override
  State<ChatWithBot> createState() => _ChatWithBotState();
}

// class _ChatWithBotState extends State<ChatWithBot> {
//   bool showInstructionEditor = false;
//   Bot? currentBot;
//   void changeConversation() {
//     print("Conversation changed");
//   }

//   void openNewChat() {
//     print("New chat opened");
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadBotDetails();
//   }

//   Future<void> _loadBotDetails() async {
//     try {
//       final bot = await context.read<BotProvider>().getBot(widget.bot.id);
//       setState(() {
//         currentBot = bot;
//       });
//     } catch (e) {
//       print('Error loading bot details: $e');
//       setState(() {
//         currentBot = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

//     if (currentBot == null) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFFEBEFFF),
//           title: const Text('Loading Bot'),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFEBEFFF),
//         title: Text(currentBot!.name,
//             style: const TextStyle(fontWeight: FontWeight.bold)),
//         actions: [
//           ...buildActions(context, tokenUsageProvider.tokenUsage),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (showInstructionEditor && currentBot != null)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: Text(currentBot!.instructions ?? ''),
//               ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   ChatBubble(isBot: true, text: "Hi, I'm ${currentBot!.name}."),
//                   ChatBubble(
//                     isBot: false,
//                     text: "I need your help to do something...",
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             InputBotBox(
//               changeConversation: changeConversation,
//               openNewChat: openNewChat,
//               listKnownledge: currentBot?.knowledge ?? [],
//               botId: widget.bot.id,
//               botProvider: context.read<BotProvider>(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
class _ChatWithBotState extends State<ChatWithBot> {
  bool showInstructionEditor = false;
  Bot? currentBot;
  bool isUpdatingInstruction = false;
  bool showUpdateSuccess = false;
  Timer? _debounce;
  final TextEditingController instructionController = TextEditingController();
  final TextEditingController chatController = TextEditingController();
  void changeConversation() {
    print("Conversation changed");
  }

  void openNewChat() {
    print("New chat opened");
  }

  @override
  void initState() {
    super.initState();
    _loadBotDetails();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadBotDetails() async {
    try {
      final bot = await context.read<BotProvider>().getBot(widget.bot.id);
      setState(() {
        currentBot = bot;
        instructionController.text = bot.instructions ?? '';
      });
    } catch (e) {
      print('Error loading bot details: $e');
      setState(() {
        currentBot = null;
      });
    }
  }

  Future<void> _handleInstructionUpdate(String newInstruction) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    setState(() => isUpdatingInstruction = true);

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final status = await widget.botProvider.updateBot(
          widget.bot.id,
          currentBot!.name,
          newInstruction,
          currentBot!.description,
        );

        if (status && mounted) {
          widget.botProvider.clearListBot();
          widget.botProvider.loadBots('');
          await _loadBotDetails(); // Reload current bot

          setState(() {
            showUpdateSuccess = true;
            isUpdatingInstruction = false;
          });

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() => showUpdateSuccess = false);
            }
          });
        }
      } catch (e) {
        print('Error updating instructions: $e');
        if (mounted) {
          setState(() => isUpdatingInstruction = false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    if (currentBot == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          title: const Text('Loading Bot'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        title: Text(currentBot!.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          ...buildActions(context, tokenUsageProvider.tokenUsage),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(isBot: true, text: "Hi, I'm ${currentBot!.name}."),
                  ChatBubble(
                    isBot: false,
                    text: "I need your help to do something...",
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: const Color.fromARGB(255, 83, 82, 82),
            ),
            const SizedBox(height: 10),
            InputBotBox(
              changeConversation: changeConversation,
              openNewChat: openNewChat,
              listKnownledge: currentBot?.knowledge ?? [],
              botId: widget.bot.id,
              instructionController: instructionController,
              chatController: chatController,
              isUpdating: isUpdatingInstruction,
              showSuccess: showUpdateSuccess,
              onInstructionChange: _handleInstructionUpdate,
            )
          ],
        ),
      ),
    );
  }
}
