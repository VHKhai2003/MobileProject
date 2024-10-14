import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const Row(),
    );
  }
}
