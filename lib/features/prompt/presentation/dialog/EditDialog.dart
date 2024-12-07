import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/dialog/radio-button/PrivatePublicOption.dart';
import 'package:code/features/prompt/presentation/dialog/text-field/CustomTextField.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dropdown-menu/CategoryMenu.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key, required this.prompt});

  final Prompt prompt;

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
      selectedCategory = category ?? 'other';
    });
  }

  late TextEditingController promptNameController;
  late TextEditingController promptDescriptionController;
  late TextEditingController promptContentController;

  bool showProgressIndicator = false;

  void handleSubmit() async {

    // validate
    String title = promptNameController.text;
    String content = promptContentController.text;
    if(title.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'Title must not be empty',
      );
      return;
    }
    if(content.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: 'Prompt content must not be empty',
      );
      return;
    }
    setState(() {
      showProgressIndicator = true;
    });

    Prompt updatedPrompt = Prompt(widget.prompt.id, title, content, !isPrivate, widget.prompt.isFavorite, description: promptDescriptionController.text, category: selectedCategory);
    PromptApiService promptApiService = PromptApiService();
    bool updateStatus = await promptApiService.updatePrompt(updatedPrompt);
    Navigator.of(context).pop(updateStatus);
  }

  @override
  void initState() {
    super.initState();
    promptNameController = TextEditingController(text: widget.prompt.title);
    promptDescriptionController = TextEditingController(text: widget.prompt.description);
    promptContentController = TextEditingController(text: widget.prompt.content);
    selectedCategory = widget.prompt.category;
    isPrivate = !widget.prompt.isPublic;
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
          Expanded(
            child: const Text('Edit Prompt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          IconButton(onPressed: () {
            Navigator.of(context).pop(false);
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
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
            onPressed: handleSubmit,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
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
                const Text('Save',),
              ],
            ),
        ),
      ],
    );
  }
}