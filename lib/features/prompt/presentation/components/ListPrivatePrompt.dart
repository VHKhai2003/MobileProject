import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/components/EmptyList.dart';
import 'package:code/features/prompt/presentation/dialog/DeleteDialog.dart';
import 'package:code/features/prompt/presentation/dialog/EditDialog.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';

class ListPrivatePrompt extends StatefulWidget {
  ListPrivatePrompt({super.key, required this.keyword, required this.current});

  String keyword;
  DateTime current;

  @override
  State<ListPrivatePrompt> createState() => _ListPrivatePromptState();
}

class _ListPrivatePromptState extends State<ListPrivatePrompt> {

  bool hasNext = false;
  int offset = 0;
  List<Prompt> prompts = [];
  bool isNotFound = false;

  void _loadPrompts() async {
    try {
      PromptApiService promptApiService = PromptApiService();
      Map<String, dynamic> params = {
        "query": widget.keyword,
        "offset": offset,
        "limit": 20,
        "isPublic": false
      };
      Map<String, dynamic> data = await promptApiService.getPrompts(params);

      // update state
      setState(() {
        hasNext = data["hasNext"];
        prompts.addAll(List<Prompt>.from(
            data["items"].map((item) => Prompt.fromJson(item))
        ));
        isNotFound = prompts.isEmpty;
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }

  }

  @override
  void didUpdateWidget(covariant ListPrivatePrompt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keyword != widget.keyword || !oldWidget.current.isAtSameMomentAs(widget.current)) {
      setState(() {
        prompts.clear();
        hasNext = false;
        offset = 0;
      });
      _loadPrompts();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPrompts();
  }

  @override
  Widget build(BuildContext context) {
    if(isNotFound) {
      return EmptyList();
    }

    int numberOfPrompts = prompts.length;
    return Expanded(
        child: ListView.separated(
          itemCount: numberOfPrompts + 1,
          itemBuilder: (context, index) {
            if(index == numberOfPrompts) {
              return hasNext ? TextButton(
                onPressed: () {
                  offset = offset + 20;
                  _loadPrompts();
                },
                child: Text("More...", style: TextStyle(color: Colors.blue),),
              ) : SizedBox.shrink();
            }
            final prompt = prompts[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(prompt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        bool? updateStatus = await showDialog(context: context, builder: (context) => EditDialog(prompt: prompt));
                        if(updateStatus != null && updateStatus!) {
                          prompts.clear();
                          offset = 0;
                          hasNext = false;
                          _loadPrompts();
                        }
                      },
                      icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                      onPressed: () async {
                        bool? deleteStatus = await showDialog(context: context, builder: (context) => DeleteDialog(prompt: prompt,));
                        if(deleteStatus != null && deleteStatus!) {
                          prompts.clear();
                          offset = 0;
                          hasNext = false;
                          _loadPrompts();
                        }
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                    onPressed: () async {
                      String? data = await showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
                      if(data != null && data.trim().isNotEmpty) {
                        Navigator.of(context).pop(data!);
                      }
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 18,),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.blueGrey,
              thickness: 0.5,
            );
          },
        )
    );
  }
}
