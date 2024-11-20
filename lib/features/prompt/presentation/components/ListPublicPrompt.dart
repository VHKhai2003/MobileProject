import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/components/EmptyList.dart';
import 'package:code/features/prompt/presentation/dialog/InfoDialog.dart';
import 'package:code/features/prompt/services/PromptApiService.dart';
import 'package:flutter/material.dart';


class ListPublicPrompt extends StatefulWidget {
  ListPublicPrompt({super.key, required this.keyword, required this.category, required this.isFavorite, required this.current});

  String keyword;
  bool isFavorite;
  String category;
  DateTime current;

  @override
  State<ListPublicPrompt> createState() => _ListPublicPromptState();
}

class _ListPublicPromptState extends State<ListPublicPrompt> {

  bool hasNext = false;
  int offset = 0;
  List<Prompt> prompts = [];
  bool isNotFound = false;

  void _loadPrompts() async {
    Map<String, dynamic> params = {
      "query": widget.keyword,
      "offset": offset,
      "limit": 20,
      "isPublic": true,
      "isFavorite": widget.isFavorite,
    };
    if(widget.category != 'all') {
      params["category"] = widget.category;
    }
    // call api
    try {
      PromptApiService promptApiService = PromptApiService();
      Map<String, dynamic> data = await promptApiService.getPrompts(params);

      // update state
      setState(() {
        hasNext = data["hasNext"];
        prompts.addAll(
            List<Prompt>.from(
            data["items"].map((item) => Prompt.fromJson(item))
          )
        );
        isNotFound = prompts.isEmpty;
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }
  }
  void toggleFavorite(Prompt prompt) async {
    // for user experience
    setState(() {
      prompt.isFavorite = !prompt.isFavorite;
    });
    PromptApiService promptApiService = PromptApiService();
    bool status = await promptApiService.toggleFavorite(prompt);
    if(!status) {
      // rollback if fail
      setState(() {
        prompt.isFavorite = !prompt.isFavorite;
      });
    }
  }


  // when changing keyword, category, isfavorite
  @override
  void didUpdateWidget(covariant ListPublicPrompt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keyword != widget.keyword
        || oldWidget.category != widget.category
        || oldWidget.isFavorite != widget.isFavorite
        || !oldWidget.current.isAtSameMomentAs(widget.current)
    ) {
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prompt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                  Text(
                    prompt.description.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 13, color: Colors.blueGrey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      prompt.isFavorite ? Icons.star : Icons.star_border,
                      color: prompt.isFavorite ? Colors.yellow : null,
                      size: 18,
                    ),
                    onPressed: () {
                      toggleFavorite(prompt);
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        bool? status = await showDialog(context: context, builder: (context) => InfoDialog(prompt: prompt));
                        if(status != null && status!) {
                          String? data = await showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
                          if(data != null && data.trim().isNotEmpty) {
                            Navigator.of(context).pop(data!);
                          }
                        }
                      },
                      icon: const Icon(Icons.info_outline_rounded, color: Colors.blueGrey, size: 18)
                  ),
                  IconButton(
                    onPressed: () async {
                      String? data = await showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
                      if(data != null && data.trim().isNotEmpty) {
                        Navigator.of(context).pop(data!);
                      }
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 18),
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
