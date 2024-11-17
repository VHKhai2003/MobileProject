import 'package:code/views/prompt/UsingPromptBottomSheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../models/Prompt.dart';
import '../dialog/DeleteDialog.dart';
import '../dialog/EditDialog.dart';

class ListPrivatePrompt extends StatefulWidget {
  ListPrivatePrompt({super.key, required this.keyword});

  String keyword;

  @override
  State<ListPrivatePrompt> createState() => _ListPrivatePromptState();
}

final dio = Dio();

class _ListPrivatePromptState extends State<ListPrivatePrompt> {

  bool hasNext = false;
  int offset = 0;
  List<Prompt> prompts = [];

  void _loadPrompts() async {
    String apiUrl = "https://api.jarvis.cx/api/v1/prompts";
    String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM5NjYzYTY0LTZiOTYtNGQwMC1hNzM2LTJhYTg4MTEyNDdiNSIsImVtYWlsIjoid2FuZ2thaTE3MjAwMkBnbWFpbC5jb20iLCJpYXQiOjE3MzE4MzAzODQsImV4cCI6MTczMTgzMjE4NH0.clfNN7Ieg9MR-PWXTNWPXJiitAneEX4mpwhFYG4siy8";
    // call api
    try {
      final response = await dio.get(
          apiUrl,
          queryParameters: {
            "query": widget.keyword,
            "offset": 0,
            "limit": 20,
            "isPublic": false
          },
          options: Options(
              headers: {
                "Authorization": "Bearer $accessToken"
              },
          )
      );

      // update state
      setState(() {
        prompts = List<Prompt>.from(
            response.data["items"].map((item) => Prompt.fromJson(item))
        );
      });
    } catch (e) {
      print('Error when fetching prompt!\n$e');
    }

  }

  @override
  void didUpdateWidget(covariant ListPrivatePrompt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keyword != widget.keyword) {
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
              title: Text(prompt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => EditDialog(prompt: prompt));
                      },
                      icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => const DeleteDialog());
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.blueGrey, size: 18,)
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => UsingPromptBottomSheet(prompt: prompt));
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
