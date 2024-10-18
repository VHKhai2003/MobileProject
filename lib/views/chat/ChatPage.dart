import 'package:code/views/appbar/CustomAppBar.dart';
import 'package:code/views/chat/Conversation.dart';
import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/views/chat/chatbox/ChatBox.dart';
import 'package:code/views/chat/EmptyConversation.dart';

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
      appBar: const CustomAppBar(),
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
