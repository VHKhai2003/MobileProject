import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ChatProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:code/features/chat/presentation/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/features/chat/presentation/chatbox/ChatBox.dart';
import 'package:code/features/chat/presentation/EmptyConversation.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FocusNode promptFocusNode = FocusNode();

  bool isEmpty = true;
  void _handleNewChat() {
    setState(() {
      isEmpty = true;
    });
  }
  void _handleOpenConversation() {
    setState(() {
      isEmpty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AiModelProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider(context.read<TokenUsageProvider>())),
        ChangeNotifierProvider(create: (context) => ConversationsProvider(context.read<ChatProvider>(), context.read<AiModelProvider>())),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          promptFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: buildActions(context, tokenUsageProvider.tokenUsage),
          ),
          drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
          body: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                isEmpty ? EmptyConversation() : Expanded(child: Conversation(isConversationHistory: isEmpty)),
                Chatbox(
                  isNewChat: isEmpty,
                  changeConversation: _handleOpenConversation,
                  openNewChat: _handleNewChat,
                  promptFocusNode: promptFocusNode
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
