import 'package:code/features/chat/providers/ConversationsProvider.dart';
import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/PromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuggestionPrompt extends StatefulWidget {
  const SuggestionPrompt({super.key, required this.promptController, required this.changeConversation});

  final TextEditingController promptController;
  final VoidCallback changeConversation;

  @override
  State<SuggestionPrompt> createState() => _SuggestionPromptState();
}

class _SuggestionPromptState extends State<SuggestionPrompt> {

  List<Prompt> prompts = [];

  Widget _buildPromptItem(Prompt prompt) {
    final conversationProvider = Provider.of<ConversationsProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prompt.title),
          IconButton(
              onPressed: () async {
                String? data = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => UsingPromptBottomSheet(prompt: prompt)
                );
                if(data != null) {
                  final regex = RegExp(r'\[.*?\]');
                  if (regex.hasMatch(data)) {
                    widget.promptController.text = data.toString();
                  } else {
                    conversationProvider.createNewThreadChat(data);
                    widget.changeConversation();
                  }
                }
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 16,)
          ),
        ],
      ),
    );
  }

  void loadPrompt() async {
    // get some prompts
    Map<String, dynamic> params = {
      "offset": 0,
      "limit": 3,
      "isPublic": true,
      "category": "writing"
    };
    try {
      PromptApiService promptApiService = PromptApiService();
      Map<String, dynamic> data = await promptApiService.getPrompts(params);
      // update state
      setState(() {
        prompts = List<Prompt>.from(
            data["items"].map((item) => Prompt.fromJson(item))
        );
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPrompt();
  }

  @override
  Widget build(BuildContext context) {
    final conversationProvider = Provider.of<ConversationsProvider>(context);

    return prompts.isNotEmpty ?
    Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("You don't know what to say, use a prompt", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 100, 116, 139)),)),
                    TextButton(
                        onPressed: () async {
                          String? data = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return PromptBottomSheet();
                              },
                              barrierColor: Colors.black.withOpacity(0.2)
                          );
                          if(data != null) {
                            final regex = RegExp(r'\[.*?\]');
                            if (regex.hasMatch(data)) {
                              widget.promptController.text = data.toString();
                            } else {
                              conversationProvider.createNewThreadChat(data);
                              widget.changeConversation();
                            }
                          }
                        },
                        child: Text("View all...", style: TextStyle(fontSize: 13, color: Colors.blue),),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: prompts.map((prompt) => _buildPromptItem(prompt)).toList(),
              )
            ],
          ) :
    SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
