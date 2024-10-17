import 'package:code/views/prompt/UsingPromptBottomSheet.dart';
import 'package:code/views/prompt/dialog/InfoDialog.dart';
import 'package:flutter/material.dart';

import '../../../models/Prompt.dart';

class ListPublicPrompt extends StatefulWidget {
  const ListPublicPrompt({super.key});

  @override
  State<ListPublicPrompt> createState() => _ListPublicPromptState();
}

class _ListPublicPromptState extends State<ListPublicPrompt> {

  final List<PublicPrompt> prompts = [
    PublicPrompt('Recognize Language', 'Tell me what , Tell me what language is this and translate it into [Language]', 'Business', true, description: 'Help user determine the language of the sentence and translate it to english'),
    PublicPrompt('Fixy', "Check and correct grammar and spells, but before doing that do not use something like [don't] instead of that, [use do not]. Make the sentence short and formal.", 'Writing', false),
    PublicPrompt('Translate RU', 'Fix grammar and translate into russian: [sentence]', 'Business', false),
    PublicPrompt('Translate russian', 'Translate text into russian', 'Writing',true , description: 'Translate text into russian'),
    PublicPrompt('Give information about a topic', 'Give me some information about the [TOPIC], contains [KEYWORDS]', 'SEO', true, description: 'Give the user some information about the [TOPIC]'),
    PublicPrompt('Translate russian', 'Translate text into russian', 'SEO', true, description: 'Translate text into russian'),
    PublicPrompt('Translate chinese', 'Translate text into chinese', 'Education', false)
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prompt.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                  Text(
                    prompt.description.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 13, color: Colors.blueGrey),
                  ),
                ],
              ),
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
                        showDialog(context: context, builder: (context) => InfoDialog(prompt: prompt));
                      },
                      icon: const Icon(Icons.info_outline_rounded, color: Colors.blueGrey, size: 18)
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 18),
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
