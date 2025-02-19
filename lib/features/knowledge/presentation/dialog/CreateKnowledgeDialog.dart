import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateKnowledgeDialog extends StatefulWidget {
  CreateKnowledgeDialog({super.key, required this.knowledgeProvider});
  KnowledgeProvider knowledgeProvider;

  @override
  State<CreateKnowledgeDialog> createState() => _CreateKnowledgeDialogState();
}

class _CreateKnowledgeDialogState extends State<CreateKnowledgeDialog> {
  final TextEditingController knowledgeNameController = TextEditingController();
  final TextEditingController knowledgeDescriptionController = TextEditingController();

  final FocusNode knowledgeNameFocusNode = FocusNode();
  final FocusNode knowledgeDescriptionFocusNode = FocusNode();

  late int knowledgeNameCharacterCount = 0;
  late int knowledgeDescriptionCharacterCount = 0;
  
  bool isLoading = false;

  @override
  void dispose() {
    knowledgeNameController.dispose();
    knowledgeDescriptionController.dispose();
    knowledgeNameFocusNode.dispose();
    knowledgeDescriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Create New Knowledge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 400,
          child: ListView(
            children: [
              Image.asset('assets/icons/knowledge-base.png', width: 80, height: 80, fit: BoxFit.contain,),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(children: <TextSpan>[
                const TextSpan(text: "* ", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                TextSpan(
                  text: "Knowledge name",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
                ),
              ])),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      controller: knowledgeNameController,
                      focusNode: knowledgeNameFocusNode,
                      cursorColor: Colors.blue.shade700,
                      style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade700, width: 1),
                        ),
                      ),
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(knowledgeDescriptionFocusNode);
                      },
                      onChanged: (value) {
                        setState(() {
                          knowledgeNameCharacterCount = value.length;
                        });
                      }),
                  SizedBox(height: 3),
                  Text("$knowledgeNameCharacterCount/50", style: TextStyle(color: Colors.grey, fontSize: 15))
                ],
              ),
              SizedBox(height: 20),
              Text("Knowledge description", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      controller: knowledgeDescriptionController,
                      focusNode: knowledgeDescriptionFocusNode,
                      maxLines: 5,
                      minLines: 3,
                      cursorColor: Colors.blue.shade700,
                      style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade700, width: 1),
                        ),
                      ),
                      scrollController: ScrollController(),
                      onChanged: (value) {
                        setState(() {
                          knowledgeDescriptionCharacterCount = value.length;
                        });
                      }),
                  SizedBox(height: 3),
                  Text("$knowledgeDescriptionCharacterCount/2000", style: TextStyle(color: Colors.grey, fontSize: 15))
                ],
              ),
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
              onPressed: () async {
                String name = knowledgeNameController.text;
                if(name.trim().isEmpty) {
                  Fluttertoast.showToast(msg: 'Knowledge name must not be empty',);
                  return;
                }
                if(knowledgeDescriptionController.text.length > 2000) {
                  Fluttertoast.showToast(msg: 'Description is too long',);
                  return;
                }
                if(name.length > 50) {
                  Fluttertoast.showToast(msg: 'Knowledge name is too long',);
                  return;
                }
                // loading, call api
                setState(() {isLoading = true;});
                bool status = await widget.knowledgeProvider.createKnowledge(name, knowledgeDescriptionController.text);
                setState(() {isLoading = false;});
                Fluttertoast.showToast(msg: status ? "Create knowledge successfully" : "Failed to create knowledge");
                if(status) {
                  Navigator.of(context).pop(status);
                }
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700,),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading ? SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),
                  ) : SizedBox.shrink(),
                  SizedBox(width: 4,),
                  const Text('Confirm'),
                ],
              )),
        ],
      ),
    );
  }
}
