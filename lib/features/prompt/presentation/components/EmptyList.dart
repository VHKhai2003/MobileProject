import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.find_in_page_outlined, size: 36, color: Colors.blue.shade700,),
              Text("No prompt found", style: TextStyle(fontSize: 18),)
            ],
          ),
        )
    );
  }
}
