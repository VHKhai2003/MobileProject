import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:flutter/material.dart';

class DeleteKnowledgeDialog extends StatelessWidget {
  const DeleteKnowledgeDialog({super.key, required this.knowledge, required this.deleteKnowledge});
  final Knowledge knowledge;
  final Function(String) deleteKnowledge;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Delete Knowledge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 70,
        child: Text(
          "Are you sure you want to delete this knowledge?",
          style: TextStyle(
            fontSize: 20
          ),
          textAlign: TextAlign.center,
        ),
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
              deleteKnowledge(knowledge.id);
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: const Text('Confirm')
        ),
      ],
    );
  }
}
