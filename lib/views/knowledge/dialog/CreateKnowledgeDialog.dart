import 'package:code/models/Knowledge.dart';
import 'package:flutter/material.dart';

class CreateKnowledgeDialog extends StatefulWidget {
  const CreateKnowledgeDialog({super.key, required this.createNewKnowledge});
  final Function(Knowledge) createNewKnowledge;

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
            IconButton(onPressed: () {
              Navigator.of(context).pop();
            }, icon: const Icon(Icons.close)),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 400,
          child: ListView(
            children: [
              Image.asset(
                'assets/icons/knowledge-base.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              RichText(text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "* ",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold
                      )
                  ),
                  TextSpan(
                      text: "Knowledge name",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                      ),
                  ),
                ]
              )),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: knowledgeNameController,
                    focusNode: knowledgeNameFocusNode,
                    cursorColor: Colors.indigoAccent,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: const Color.fromRGBO(242, 243, 250, 1),
                      // hintText: "Type the text here...",
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
                        borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
                      ),
                    ),
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(knowledgeDescriptionFocusNode);
                    },
                    onChanged: (value) {
                      setState(() {
                        knowledgeNameCharacterCount = value.length;
                      });
                    }
                  ),
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
                    cursorColor: Colors.indigoAccent,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: const Color.fromRGBO(242, 243, 250, 1),
                      // hintText: "Type the text here...",
                      // hintStyle: const TextStyle(color: Colors.grey),
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
                        borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
                      ),
                    ),
                    scrollController: ScrollController(),
                    onChanged: (value) {
                      setState(() {
                        knowledgeDescriptionCharacterCount = value.length;
                      });
                    }
                  ),
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
              onPressed: () {
                DateTime now = DateTime.now();
                int day = now.day;
                int month = now.month;
                int year = now.year;
                String formattedDate = "$day/${month < 10 ? '0$month' : month}/$year";
                widget.createNewKnowledge(
                    Knowledge(
                        DateTime.now().millisecondsSinceEpoch.toString(),
                        knowledgeNameController.text,
                        knowledgeDescriptionController.text,
                        0,
                        0,
                        formattedDate,
                        true
                    )
                );
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              child: const Text('Confirm')
          ),
        ],
      ),
    );
  }
}
