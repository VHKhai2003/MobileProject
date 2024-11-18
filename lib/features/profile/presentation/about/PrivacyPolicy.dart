import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.policy, color: Colors.blue),
        title: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
