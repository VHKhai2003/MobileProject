import 'package:code/models/Unit.dart';
import 'package:flutter/material.dart';

class DeleteUnitDialog extends StatelessWidget {
  const DeleteUnitDialog({super.key, required this.unit});
  final Unit unit;
  // final Function(String) deleteUnit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Delete Unit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 70,
        child: Text(
          "Are you sure you want to delete this unit?",
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
