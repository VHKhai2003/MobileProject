import 'package:code/views/knownledge/dialog/SelectUnitTypeDialog.dart';
import 'package:flutter/material.dart';
import 'AddUnit.dart';

void showCreateKnowledgeDialog(
    BuildContext context,
    List<Map<String, dynamic>> data,
    Function(String) onNameChanged,
    Function(String) onDescriptionChanged,
    Function(String) onUnitSelected,
    String selectedUnit) {
  String knowledgeName = ''; // Local variable to hold knowledge name
  String knowledgeDescription =
      ''; // Local variable to hold knowledge description

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create New Knowledge'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storage, size: 50, color: Colors.orange),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Knowledge name',
                hintText: 'Enter name',
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
              onChanged: (value) {
                knowledgeName = value; // Update local variable
                onNameChanged(value); // Call the callback
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Knowledge description',
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              ),
              maxLength: 2000,
              maxLines: 3,
              onChanged: (value) {
                knowledgeDescription = value; // Update local variable
                onDescriptionChanged(value); // Call the callback
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (knowledgeName.isNotEmpty) {
                Navigator.of(context).pop();
                // Call to show select unit dialog
                showDialog(context: context, builder: (context) => SelectUnitTypeDialog());
              }
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
}
