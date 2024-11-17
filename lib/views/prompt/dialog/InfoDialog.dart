import 'package:flutter/material.dart';
import '../../../models/Prompt.dart';

class InfoDialog extends StatelessWidget {
  InfoDialog({super.key, required this.prompt});
  
  Prompt prompt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(prompt.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prompt.category, style: const TextStyle(fontSize: 14),),
          const SizedBox(height: 6,),
          Text(prompt.description, style: const TextStyle(fontSize: 12, color: Colors.blueGrey),),
          const SizedBox(height: 10,),
          const Text('Prompt', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
          Container(
            width: double.maxFinite,
            height: prompt.content.length > 250 ? 130 : 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(12)),
              child: SingleChildScrollView(child: Text(prompt.content,)),
            ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
            onPressed: () {
              // Handle the create action
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: const Text('Use This Prompt',)
        ),
      ],
    );
  }
}
