import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Delete Prompt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: const Text('Are you sure you want to delete this prompt?'),
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
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete',)
        ),
      ],
    );
  }
}
