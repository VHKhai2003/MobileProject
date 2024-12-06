import 'package:code/features/chat/presentation/suggestion/SuggestionPrompt.dart';
import 'package:flutter/material.dart';

class EmptyConversation extends StatelessWidget {
  const EmptyConversation({super.key, required this.promptController, required this.changeConversation});
  final TextEditingController promptController;
  final VoidCallback changeConversation;

  String getPartOfDay() {
    int currentHour = DateTime.now().hour;
    if(currentHour > 5 && currentHour < 11) {
      return "morning";
    }
    else if(currentHour >= 11 && currentHour < 18) {
      return "afternoon";
    }
    return "evening";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ListView(
          children: [
            const Text("👋", style: TextStyle(fontSize: 36, color: Colors.yellow),),
            Text("Hello, Good ${getPartOfDay()}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),),
            const Text("I'm Jarvis, your personal assistant"),
            const SizedBox(height: 32,),
            SuggestionPrompt(
              promptController: promptController,
              changeConversation: changeConversation,
            ),
          ],
        ),
      ),
    );
  }
}