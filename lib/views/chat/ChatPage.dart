import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/views/chat/chatbox/ChatBox.dart';
import 'package:code/views/chat/EmptyConversation.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              child: Row(
                children: [
                  Text('Upgrade', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(width: 4,),
                  Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 16,)
                ],
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
            child: Row(
              children: [
                const Text('50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                Icon(Icons.local_fire_department_rounded, color: Colors.blue.shade700, size: 13,)
              ],
            ),
          )
        ],
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: const Column(
          children: [
            EmptyConversation(),
            Chatbox()
          ],
        ),
      ),
    );
  }
}
