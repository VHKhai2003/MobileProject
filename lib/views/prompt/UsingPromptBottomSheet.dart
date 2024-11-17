import 'package:code/models/Prompt.dart';
import 'package:code/views/prompt/dialog/text-field/CustomTextField.dart';
import 'package:flutter/material.dart';

class UsingPromptBottomSheet extends StatefulWidget {
  UsingPromptBottomSheet({super.key, required this.prompt});
  Prompt prompt;

  @override
  State<UsingPromptBottomSheet> createState() => _UsingPromptBottomSheetState();
}

class _UsingPromptBottomSheetState extends State<UsingPromptBottomSheet> {

  List<TextEditingController> controllers = [];
  List<String> keywords = [];
  late Prompt prompt;
  bool isShowPrompt = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prompt = widget.prompt;
    String content = prompt.content;
    // Sd regular expression de tim cac chuoi nam trong dau []
    RegExp regExp = RegExp(r'\[([^\]]+)\]');
    Iterable<RegExpMatch> matches = regExp.allMatches(content);
    // Lay cac chuoi nam trong dau ngoac vuong
    keywords = matches.map((match) {
      String keyword = match.group(1)!;
      controllers.add(TextEditingController());
      return keyword;
    }).toList();
    if(keywords.isEmpty) {
      setState(() {
        isShowPrompt = true;
      });
    }
  }

  @override
  void dispose() {
    for(TextEditingController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: isShowPrompt ? 350 : 300,
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prompt.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close))
            ],
          ),
          if (!isShowPrompt) TextButton(
              onPressed: () {
                setState(() {
                  isShowPrompt = true;
                });
              },
              child: const Text('View Prompt', style: TextStyle(fontSize: 14, color: Colors.blue),)
          ) else Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Prompt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                  TextButton(onPressed: () {}, child: const Text('Add to chat input', style: TextStyle(color: Colors.blue, fontSize: 13),))
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                width: double.maxFinite,
                height: 80,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey.shade50
                ),
                child: SingleChildScrollView(child: Text(prompt.content)),
              )
            ],
          ),
          keywords.isEmpty ? const SizedBox.shrink() : const Text('User input', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          const SizedBox(height: 4,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: keywords.asMap().entries.map((entry) {
                    int index = entry.key;
                    String keyword = entry.value;
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: CustomTextField(controller: controllers[index], hinText: keyword,)
                    );
                  }).toList(),
                ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700),
                      child: const Text('Send')
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
