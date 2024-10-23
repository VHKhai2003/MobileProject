import 'package:flutter/material.dart';
import 'package:code/views/appbar/BuildActions.dart';
import 'package:code/views/bot/widgets/BotCard.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/views/bot/screens/BotDashboard.dart'; // Đảm bảo đúng đường dẫn
import 'package:code/views/bot/screens/AddBot.dart';
import 'package:code/views/bot/screens/ChatWithBot.dart'; // Đảm bảo đường dẫn đúng

class MainBot extends StatelessWidget {
  final List<Map<String, String>> bots = [
    {
      'name': 'Bot1',
      'description': 'This is a first bot',
      'date': '6/10/2024',
    },
    {
      'name': 'Bot2',
      'description': 'This is second bot',
      'date': '6/10/2024',
    },
  ];

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
          children: [
            BotDashboard(
              onBotTypeChanged: (type) {
                print("Selected bot type: $type");
              },
              onSearch: (query) {
                print("Search query: $query");
              },
              onCreateBot: () {
                showDialog(
                  context: context,
                  builder: (context) => AddBot(), // Gọi widget AddBot
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bots.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: BotCard(
                      name: bots[index]['name']!,
                      description: bots[index]['description']!,
                      date: bots[index]['date']!,
                      onFavorite: () {
                        // Xử lý khi nhấn dấu sao
                      },
                      onDelete: () {
                        // Xử lý khi nhấn thùng rác
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatWithBot(
                              botName: bots[index]
                                  ['name']!, // Truyền tên bot vào đây
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
