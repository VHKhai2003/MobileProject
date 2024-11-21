import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/PromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';

class SuggestionPrompt extends StatefulWidget {
  const SuggestionPrompt({super.key});

  @override
  State<SuggestionPrompt> createState() => _SuggestionPromptState();
}

class _SuggestionPromptState extends State<SuggestionPrompt> {

  List<Prompt> prompts = [];

  Widget _buildPromptItem(Prompt prompt) {
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
                print('data: $data');
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
    return prompts.isNotEmpty
        ? Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("You don't know what to say, use a prompt", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 100, 116, 139)),),
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

                          print('data: $data');
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
          )
        : Column();
  }
}
