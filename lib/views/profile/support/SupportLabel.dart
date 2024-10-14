import 'package:flutter/material.dart';

class SupportLabel extends StatelessWidget {
  const SupportLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Support", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      )),
    );
  }
}
