import 'package:flutter/material.dart';
import 'package:code/views/chat/chatbox/AiModels.dart';
import 'package:code/views/prompt/PromptBottomSheet.dart';

class Chatbox extends StatelessWidget {
  const Chatbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AiModels(),
              Container(
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.history, color: Colors.blueGrey,)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add_comment_outlined, color: Colors.blue.shade700,)),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 6,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade800, width: 0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Ask me anything, press '/' for prompts...",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 2, 2, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Upload image'),
                                      onTap: () {
                                        // Handle upload image action
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Take photo'),
                                      onTap: () {
                                        // Handle take photo action
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.terminal),
                                      title: const Text('Prompt'),
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true, // lam cho chieu cao bottom sheet > 1/2 man hinh
                                            builder: (context) {
                                              return Promptbottomsheet(context: context,);
                                            },
                                            barrierColor: Colors.black.withOpacity(0.2)
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            );
                          },
                          barrierColor: Colors.black.withOpacity(0.2)
                        );
                      },
                      icon: Icon(Icons.add_circle_outline, color: Colors.blueGrey),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.send, color: Colors.blueGrey),)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
