import 'package:code/models/Prompt.dart';
import 'package:code/views/prompt/dialog/radio-button/PrivatePublicOption.dart';
import 'package:code/views/prompt/dialog/text-field/CustomTextField.dart';
import 'package:flutter/material.dart';

import 'dropdown-menu/CategoryMenu.dart';

class EditDialog extends StatefulWidget {
  EditDialog({super.key, required this.prompt});

  Prompt prompt;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late bool isPrivate;

  void _updateIsPrivate(bool? value) {
    setState(() {
      isPrivate = value ?? true;
    });
  }

  late String selectedCategory;

  void _handleChangeCategory(String? category) {
    setState(() {
      selectedCategory = category ?? 'Other';
    });
  }

  late TextEditingController promptNameController;
  late TextEditingController promptDescriptionController;
  late TextEditingController promptContentController;

  @override
  void initState() {
    super.initState();
    isPrivate = widget.prompt.isPrivate;
    selectedCategory = widget.prompt.category;
    promptNameController = TextEditingController(text: widget.prompt.name);
    promptDescriptionController =
        TextEditingController(text: widget.prompt.description);
    promptContentController =
        TextEditingController(text: widget.prompt.content);
  }

  @override
  void dispose() {
    promptContentController.dispose();
    promptDescriptionController.dispose();
    promptNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Edit Prompt',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Radio buttons for Private/Public Prompt
            PrivatePublicOption(
              isPrivate: isPrivate, onChanged: _updateIsPrivate,),
        
        
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Name '),
                  Text('*', style: TextStyle(color: Colors.red),)
                ],
              ),
            ),
            // TextField for Name
            CustomTextField(
                controller: promptNameController, hinText: 'Name of the prompt'),
        
        
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Category '),
                  Text('*', style: TextStyle(color: Colors.red),)
                ],
              ),
            ),
            // dropdown menu for category
            CategoryMenu(selectedCategory: selectedCategory,
                onChanged: _handleChangeCategory),
        
        
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Description'),
                ],
              ),
            ),
            // TextField for description
            CustomTextField(
              controller: promptDescriptionController,
              hinText: 'Describe your prompts',
              maxLines: 2,
            ),
        
        
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Prompt content '),
                  Text('*', style: TextStyle(color: Colors.red),)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue.shade50,
              ),
              child: Row(
                
                children: [
                  Icon(Icons.info_rounded, color: Colors.blue.shade700, size: 14,),
                  const SizedBox(width: 4,),
                  const Expanded(
                    child: Text(
                      'Use square brackets [] to specify user input.',
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            // TextField for Prompt
            CustomTextField(
              controller: promptContentController,
              hinText: 'e.g. Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
              maxLines: 3,
            )
          ],
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
              // Handle the create action
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: const Text('Save',)
        ),
      ],
    );
  }
}