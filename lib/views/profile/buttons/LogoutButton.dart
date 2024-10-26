import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.logout, color: Colors.redAccent),
        title: const Text('Log out', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
        trailing: const Icon(Icons.chevron_right, color: Colors.redAccent,),
        onTap: () {},
      ),
    );
  }
}
