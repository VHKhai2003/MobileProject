import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  const Version({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.info, color: Colors.blue),
        title: const Text('Version', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Text("1.0.0", style: TextStyle(fontSize: 15),),
        onTap: () {},
      ),
    );
  }
}
