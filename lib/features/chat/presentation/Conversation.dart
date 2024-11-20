import 'package:code/features/chat/models/AiAgent.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

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
    final conversationsProvider = Provider.of<ConversationsProvider>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: conversationsProvider,
      child: Consumer<ConversationsProvider>(
        builder: (context, conversationsProvider, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (conversationsProvider.isLoadingConversationHistory) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.5,
                    child: Center(child: CircularProgressIndicator())
                  )
                ] else if (conversationsProvider.errorConversationHistory != null) ...[
                  Center(child: Text('Error: ${conversationsProvider.errorConversationHistory}'))
                ] else if (conversationsProvider.conversationHistory == null) ...[
                  Center(child: Text('No conversation history found.'))
                ] else ...[
                  for (var message in conversationsProvider.conversationHistory!.items) ...[
                    _buildQuestion(message.query),
                    const SizedBox(height: 20),
                    _buildResponse(
                      AiAgent('GPT-4o mini', 'assets/icons/gpt-4o-mini.png', 1),
                      message.answer,
                    ),
                    const SizedBox(height: 20),
                  ]
                ],
              ],
            ),
          );
        }
      ),
    );
  }
}
