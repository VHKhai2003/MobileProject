import 'package:code/views/prompt/dialog/dropdown-menu/CategoryMenu.dart';
import 'package:code/views/prompt/dialog/radio-button/PrivatePublicOption.dart';
import 'package:code/views/prompt/dialog/text-field/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {

  bool isPrivate = true;
  void _updateIsPrivate(bool? value) {
    setState(() {
      isPrivate = value ?? true;
    });
  }

  String selectedCategory = 'Other';
  void _handleChangeCategory(String? category) {
    setState(() {
      selectedCategory = category ?? 'Other';
    });
  }

  final TextEditingController promptNameController = TextEditingController();
  final TextEditingController promptDescriptionController = TextEditingController();
  final TextEditingController promptContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          const Text('New Prompt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
            PrivatePublicOption(isPrivate: isPrivate, onChanged: _updateIsPrivate,),
        
        
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
            CustomTextField(controller: promptNameController, hinText: 'Name of the prompt'),
        
        
            !isPrivate ? Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Category '),
                  Text('*', style: TextStyle(color: Colors.red),)
                ],
              ),
            ) : const SizedBox.shrink(),
            // dropdown menu for category
            !isPrivate ? CategoryMenu(selectedCategory: selectedCategory, onChanged: _handleChangeCategory) : const SizedBox.shrink(),
        
        
            !isPrivate ? Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: const Row(
                children: [
                  Text('Description'),
                ],
              ),
            ) : const SizedBox.shrink(),
            // TextField for description
            !isPrivate ? CustomTextField(
              controller: promptDescriptionController,
              hinText: 'Describe your prompts',
              maxLines: 2,
            ) : const SizedBox.shrink(),
        
        
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
          child: const Text('Create',)
        ),
      ],
    );
  }
}
