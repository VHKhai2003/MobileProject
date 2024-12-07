import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key, required this.prompt,});

  final Prompt prompt;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {

  bool showProgressIndicator = false;

  void handleDelete() async {
    setState(() {
      showProgressIndicator = true;
    });
    PromptApiService promptApiService = PromptApiService();
    bool deleteStatus = await promptApiService.deletePrompt(widget.prompt);
    Navigator.of(context).pop(deleteStatus);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Delete Prompt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop(false);
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: const Text('Are you sure you want to delete this prompt?'),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
            onPressed: handleDelete,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                showProgressIndicator ? SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ) : SizedBox.shrink(),
                SizedBox(width: 4,),
                const Text('Delete',),
              ],
            )
        ),
      ],
    );
  }
}
