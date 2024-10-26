import 'package:code/views/prompt/UsingPromptBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../../models/Prompt.dart';
import '../dialog/DeleteDialog.dart';
import '../dialog/EditDialog.dart';

class ListPrivatePrompt extends StatefulWidget {
  const ListPrivatePrompt({super.key});

  @override
  State<ListPrivatePrompt> createState() => _ListPrivatePromptState();
}

class _ListPrivatePromptState extends State<ListPrivatePrompt> {

  final List<PrivatePrompt> prompts = [
    PrivatePrompt('Recognize Language', 'Tell me what language is this and translate it into [language]', false),
    PrivatePrompt('Fixy', "Check and correct grammar and spells, but before doing that do not use something like [don't] instead of that, [use do not]. Make the sentence short and formal.",  true),
    PrivatePrompt('Translate RU', 'Fix grammar and translate into russian: [sentence]', true),
    PrivatePrompt('Translate russian', 'Translate text into russian', false),
    PrivatePrompt('Give information about a topic', 'Give me some information about the [TOPIC], contains [KEYWORDS]', false),
    PrivatePrompt('Translate russian', 'Translate text into russian', false),
    PrivatePrompt('Translate chinese', 'Translate text into chinese', true)
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
          itemCount: prompts.length,
          itemBuilder: (context, index) {
            final prompt = prompts[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(prompt.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      prompt.isFavorite ? Icons.star : Icons.star_border,
                      color: prompt.isFavorite ? Colors.yellow : null,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        prompt.isFavorite = !prompt.isFavorite;
                      });
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => EditDialog(prompt: prompt));
                      },
                      icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => const DeleteDialog());
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 18,),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.blueGrey,
              thickness: 0.5,
            );
          },
        )
    );
  }
}
