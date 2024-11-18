import 'package:flutter/material.dart';

class JarvisPlayground extends StatelessWidget {
  const JarvisPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.explore, color: Colors.blue),
        title: const Text('Jarvis Playground', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
