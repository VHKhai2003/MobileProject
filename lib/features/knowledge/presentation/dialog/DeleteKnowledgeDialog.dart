import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/material.dart';

class DeleteKnowledgeDialog extends StatefulWidget {
  DeleteKnowledgeDialog({super.key, required this.knowledge, required this.knowledgeProvider});
  final Knowledge knowledge;
  KnowledgeProvider knowledgeProvider;

  @override
  State<DeleteKnowledgeDialog> createState() => _DeleteKnowledgeDialogState();
}

class _DeleteKnowledgeDialogState extends State<DeleteKnowledgeDialog> {

  bool isLoading = false;

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
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              bool status = await widget.knowledgeProvider.deleteKnowledge(widget.knowledge.id);
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pop(status);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading ? SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ) : SizedBox.shrink(),
                SizedBox(width: 4,),
                const Text('Confirm'),
              ],
            )
        ),
      ],
    );
  }
}
