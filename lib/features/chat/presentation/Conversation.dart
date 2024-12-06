import 'package:code/features/chat/providers/ChatProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key, required this.isConversationHistory});
  final bool isConversationHistory;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  @override
  Widget build(BuildContext context) {
    final conversationsProvider = Provider.of<ConversationsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: conversationsProvider),
        ChangeNotifierProvider.value(value: chatProvider),
      ],
      child: Consumer2<ConversationsProvider, ChatProvider>(
        builder: (context, conversationsProvider, chatProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (conversationsProvider.isLoadingConversationHistory) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.5,
                    child: Center(child: CircularProgressIndicator())
                  )
                ] else if (conversationsProvider.errorConversationHistory != null) ...[
                  SizedBox(
                      height: MediaQuery.of(context).size.height/1.5,
                      child: Center(child: Text('Error: ${conversationsProvider.errorConversationHistory}'))
                  )
                ]
                // else if (conversationsProvider.conversationHistory == null) ...[
                //   SizedBox(
                //       height: MediaQuery.of(context).size.height/1.5,
                //       child: Center(child: Text('No conversation history found.'))
                //   )
                // ]
                else ...[
                  ...chatProvider.messages
                ],
              ],
            ),
          );
        }
      ),
    );
  }
}
