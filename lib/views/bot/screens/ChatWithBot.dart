import 'package:code/views/bot/widgets/KnowledgeDropDownTable.dart';
import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/views/appbar/BuildActions.dart';

class ChatWithBot extends StatelessWidget {
  final String botName; // Tham số bắt buộc

  const ChatWithBot({Key? key, required this.botName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        actions: buildActions(context),
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.of(context).pop(); // Quay lại màn hình trước
                  },
                ),
                SizedBox(
                    width: 10), // Khoảng cách giữa nút back và biểu tượng khác
                Icon(Icons.waving_hand, size: 40, color: Colors.orange),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Im $botName',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "I'm $botName, your bot",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Phần prompt chọn gợi ý
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Don't know what to say? Use a prompt!",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text('View all',
                    style: TextStyle(color: Colors.blue, fontSize: 14)),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: KnowledgeDropDownTable()),
              ],
            ),
            // Prompt section
            Row(
              children: [
                Icon(Icons.bolt, color: Colors.grey), // Biểu tượng prompt
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Prompt1',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Ask me anything, press '/' for prompts...",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
