import 'package:flutter/material.dart';

class AboutLabel extends StatelessWidget {
  const AboutLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("About", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      )),
    );
  }
}
