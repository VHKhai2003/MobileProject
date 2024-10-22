import 'package:flutter/material.dart';
import 'package:code/views/bot/widgets/BotCard.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;

class Mainbot extends StatelessWidget {
  final List<Map<String, String>> bots = [
    {
      'name': 'Bot1',
      'description': 'This is a first bot',
      'date': '6/10/2024',
    },
    {
      'name': 'Bot2',
      'description': '',
      'date': '6/10/2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text('Upgrade',
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              const SizedBox(width: 4),
              Icon(
                Icons.rocket_launch,
                color: Colors.blue.shade700,
                size: 20,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200),
            child: Row(
              children: [
                const Text(
                  '50',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  'assets/icons/fire.png',
                  width: 20,
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  print('Bot ${bots[index]['name']} marked as favorite');
                },
                onDelete: () {
                  // Xử lý khi nhấn thùng rác
                  print('Bot ${bots[index]['name']} deleted');
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
