import 'package:flutter/material.dart';

class AccountLabel extends StatelessWidget {
  const AccountLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Account", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      )),
    );
  }
}
