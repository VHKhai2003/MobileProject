import 'package:code/models/Knowledge.dart';
import 'package:code/views/knowledge/dialog/CreateKnowledgeDialog.dart';
import 'package:flutter/material.dart';

class CreateKnowledgeButton extends StatelessWidget {
  const CreateKnowledgeButton({super.key, required this.createNewKnowledge});
  final Function(Knowledge) createNewKnowledge;

  void _showCreateKnowledgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateKnowledgeDialog(createNewKnowledge: createNewKnowledge);
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
              onPressed: () {
                _showCreateKnowledgeDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline, size: 20),
                  SizedBox(width: 10),
                  const Text(
                    'Create knowledge',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }
}
