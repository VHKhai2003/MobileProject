import 'package:flutter/material.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({super.key, required this.icon, required this.label});
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
