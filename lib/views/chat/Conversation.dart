import 'package:code/models/AiAgent.dart';
import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key});

  Widget _buildResponse(AiAgent agent, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            agent.image,
            width: 20, height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(agent.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(content),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildQuestion(String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 10,
            backgroundColor: Colors.blue.shade700,
            child: const Text('K', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("You", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              Text(content)
            ],
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildQuestion("hello assistant"),
          const SizedBox(height: 20,),
          _buildResponse(AiAgent('GPT-4o mini', 'assets/icons/gpt-4o-mini.png', 1), "Hello! How can I assist you today?"),
          const SizedBox(height: 20,),
          _buildQuestion("Can you tell me about javascript"),
          const SizedBox(height: 20,),
          _buildResponse(AiAgent('GPT-4o mini', 'assets/icons/gpt-4o-mini.png', 1), 'Absolutely! JavaScript is a versatile, high-level programming language primarily used for creating interactive and dynamic content on the web. Here are some key points about JavaScript:'
              "\n\nClient-Side Scripting: JavaScript is mostly known for its role in client-side development, where it runs in the user's browser. This allows for real-time updates and interactions without needing to reload the page."
              "\n\nInteractivity: With JavaScript, developers can create rich user interfaces that respond to user actions, such as clicks and keyboard input, enhancing the overall user experience."
              "\n\nCompatibility: It is supported by all modern web browsers, making it a universal tool for web development. Whether you're using Chrome, Firefox, Safari, or Edge, JavaScript will work seamlessly."
              "\n\nEvent-Driven: JavaScript uses an event-driven programming model, meaning it can respond to events like mouse clicks, form submissions, and other actions.")
        ],
      ),
    );
  }
}
