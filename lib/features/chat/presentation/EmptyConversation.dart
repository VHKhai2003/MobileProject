import 'package:code/features/chat/presentation/suggestion/SuggestionPrompt.dart';
import 'package:flutter/material.dart';

class EmptyConversation extends StatelessWidget {
  const EmptyConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ListView(
          children: [
            const Text("👋", style: TextStyle(fontSize: 36, color: Colors.yellow),),
            const Text("Hello, Good morning", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),),
            const Text("I'm Jarvis, your personal assistant"),
            const SizedBox(height: 32,),
            SuggestionPrompt(),
          ],
        ),
      ),
    );
  }
}