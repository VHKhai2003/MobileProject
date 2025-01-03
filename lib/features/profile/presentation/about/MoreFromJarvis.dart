import 'package:flutter/material.dart';

class MoreFromJarvis extends StatelessWidget {
  const MoreFromJarvis({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.more_horiz, color: Colors.blue),
        title: const Text('More from EchoAI', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
