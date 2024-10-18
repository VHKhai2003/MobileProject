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
      appBar: AppBar(
        actions: [
          Container(
              child: Row(
                children: [
                  Text('Upgrade', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(width: 4,),
                  Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 20,)
                ],
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
            child: Row(
              children: [
                const Text('50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                const SizedBox(width: 5),
                Image.asset(
                  'assets/icons/fire.png',
                  width: 20,
                  height: 20,
                )
              ],
            ),
          )
        ],
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
