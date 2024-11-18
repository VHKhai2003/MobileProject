import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:code/features/chat/presentation/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/features/chat/presentation/chatbox/ChatBox.dart';
import 'package:code/features/chat/presentation/EmptyConversation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

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
    return Scaffold(
      appBar: AppBar(
        actions: buildActions(context),
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            isEmpty ? EmptyConversation() : Expanded(child: Conversation()),
            Chatbox(changeConversation: _handleOpenConversation, openNewChat: _handleNewChat,),
          ],
        ),
      ),
    );
  }
}
