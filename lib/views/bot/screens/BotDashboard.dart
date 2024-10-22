import 'package:flutter/material.dart';
import '../widgets/BotCard.dart';

class BotDashboard extends StatelessWidget {
  const BotDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bots'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Hành động tìm kiếm
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Bots'),
              ),
              const VerticalDivider(width: 20, color: Colors.white),
              TextButton(
                onPressed: () {},
                child: const Text('Knowledge'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            BotCard(
              name: 'Bot1',
              description: 'This is a first bot',
              date: '6/10/2024',
            ),
            BotCard(
              name: 'Bot2',
              description: '',
              date: '6/10/2024',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Hành động tạo bot mới
        },
        tooltip: 'Create bot',
        child: const Icon(Icons.add),
      ),
    );
  }
}
