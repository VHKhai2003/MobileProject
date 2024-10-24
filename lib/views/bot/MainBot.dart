import 'package:flutter/material.dart';
import 'package:code/views/appbar/BuildActions.dart';
import 'package:code/views/bot/widgets/BotCard.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:code/views/bot/screens/BotDashboard.dart';
import 'package:code/views/bot/screens/AddBot.dart';
import 'package:code/views/bot/screens/ChatWithBot.dart';
import 'package:code/models/Bot.dart';

class MainBot extends StatelessWidget {
  // Danh sách các bot quản lý trong MainBot
  final List<Bot> bots = [
    Bot(
      name: 'Bot1',
      description: 'This is the first bot',
      date: '6/10/2024',
      knowledge: [
        'AI Basics',
        'Machine Learning',
        'Deep Learning'
      ], // Thêm dữ liệu knowledge
    ),
    Bot(
      name: 'Bot2',
      description: 'This is the second bot',
      date: '7/10/2024',
      knowledge: [
        'Natural Language Processing',
        'Computer Vision'
      ], // Thêm dữ liệu knowledge
    ),
    Bot(
      name: 'Bot3',
      description: 'This is the third bot',
      date: '8/10/2024',
      knowledge: [
        'Reinforcement Learning',
        'AI Ethics'
      ], // Thêm dữ liệu knowledge
    ),
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
                  builder: (context) => AddBot(),
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: bots.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: BotCard(
                      name: bots[index].name,
                      description: bots[index].description,
                      date: bots[index].date,
                      onFavorite: () {
                        // Xử lý khi nhấn dấu sao
                      },
                      onDelete: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatWithBot(
                              botName: bots[index].name,
                              listKnowledge: bots[index]
                                  .knowledge, // Truyền danh sách knowledge
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
