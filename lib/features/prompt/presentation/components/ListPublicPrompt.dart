import 'package:code/features/prompt/models/Prompt.dart';
import 'package:code/features/prompt/presentation/UsingPromptBottomSheet.dart';
import 'package:code/features/prompt/presentation/dialog/InfoDialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


final dio = Dio();

class ListPublicPrompt extends StatefulWidget {
  ListPublicPrompt({super.key, required this.keyword, required this.category, required this.isFavorite});

  String keyword;
  bool isFavorite;
  String category;

  @override
  State<ListPublicPrompt> createState() => _ListPublicPromptState();
}

class _ListPublicPromptState extends State<ListPublicPrompt> {

  bool hasNext = false;
  int offset = 0;
  List<Prompt> prompts = [];

  void _loadPrompts() async {
    String apiUrl = "https://api.jarvis.cx/api/v1/prompts";
    String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5NjYzYTY0LTZiOTYtNGQwMC1hNzM2LTJhYTg4MTEyNDdiNSIsImVtYWlsIjoid2FuZ2thaTE3MjAwMkBnbWFpbC5jb20iLCJpYXQiOjE3MzE4MzAzODQsImV4cCI6MTczMTgzMjE4NH0.clfNN7Ieg9MR-PWXTNWPXJiitAneEX4mpwhFYG4siy8";
    Map<String, dynamic> params = widget.category == 'all'
        ? {
          "query": widget.keyword,
          "offset": offset,
          "limit": 20,
          "isPublic": true,
          "isFavorite": widget.isFavorite,
        }
        : {
          "query": widget.keyword,
          "offset": offset,
          "limit": 20,
          "isPublic": true,
          "isFavorite": widget.isFavorite,
          "category": widget.category,
        };
    // call api
    try {
      final response = await dio.get(
          apiUrl,
          queryParameters: params,
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken"
            },
          )
      );

      // update state
      setState(() {
        hasNext = response.data["hasNext"];
        prompts.addAll(
            List<Prompt>.from(
            response.data["items"].map((item) => Prompt.fromJson(item))
          )
        );
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }
  }

  // when changing keyword, category, isfavorite
  @override
  void didUpdateWidget(covariant ListPublicPrompt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keyword != widget.keyword || oldWidget.category != widget.category || oldWidget.isFavorite != widget.isFavorite) {
      setState(() {
        prompts.clear();
        hasNext = false;
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
    int numberOfPrompts = prompts.length;
    return Expanded(
        child: ListView.separated(
          itemCount: numberOfPrompts + 1,
          itemBuilder: (context, index) {
            if(index == numberOfPrompts) {
              return hasNext ? TextButton(
                  onPressed: () {
                    setState(() {
                      offset = offset + 20;
                    });
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
                      setState(() {
                        prompt.isFavorite = !prompt.isFavorite;
                      });
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => InfoDialog(prompt: prompt));
                      },
                      icon: const Icon(Icons.info_outline_rounded, color: Colors.blueGrey, size: 18)
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
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
