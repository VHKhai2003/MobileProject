import 'package:flutter/material.dart';
import 'package:code/models/Prompt.dart';

class ListPrompts extends StatefulWidget {
  ListPrompts({super.key});

  @override
  State<ListPrompts> createState() => _ListPromptsState();
}

class _ListPromptsState extends State<ListPrompts> {
  final List<Prompt> prompts = [
    Prompt('Recognize Language', 'Tell me what language is this and translate it into English', true, 'Business', description: 'Help user determine the language of the sentence and translate it to english'),
    Prompt('Fixy', "Check and correct grammar and spells, but before doing that do not use something like [don't] instead of that, [use do not]. Make the sentence short and formal.", true, 'Writing', isFavorite: true),
    Prompt('Translate RU', 'Fix grammar and translate into russian.', true, 'Business'),
    Prompt('Translate russian', 'Translate text into russian', true, 'Writing', description: 'Translate text into russian'),
    Prompt('Give information about a topic', 'Give me some information about the [TOPIC]', true, 'SEO', description: 'Give the user some information about the [TOPIC]', isFavorite: true),
    Prompt('Translate russian', 'Translate text into russian', true, 'SEO', description: 'Translate text into russian'),
    Prompt('Translate chinese', 'Translate text into russian', true, 'Education')
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
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    prompt.isFavorite ? Icons.star : Icons.star_border,
                    color: prompt.isFavorite ? Colors.yellow : null,
                  ),
                  onPressed: () {
                    setState(() {
                      prompt.isFavorite = !prompt.isFavorite;
                    });
                  },
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline_rounded, color: Colors.blueGrey,)
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline, color: Colors.blueGrey,)
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, color: Colors.blue),
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
