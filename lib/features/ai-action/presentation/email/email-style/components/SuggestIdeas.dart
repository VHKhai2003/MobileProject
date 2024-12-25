import 'package:code/features/ai-action/presentation/email/components/promptEmailChatBox.dart';
import 'package:code/features/ai-action/providers/EmailProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SuggestIdeas extends StatefulWidget {
  const SuggestIdeas({super.key, required this.receivedEmailController});
  final TextEditingController receivedEmailController;

  @override
  State<SuggestIdeas> createState() => _SuggestIdeasState();
}

class _SuggestIdeasState extends State<SuggestIdeas> {
  Widget _buildSuggestIdeasItem(String idea) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(idea)),
          IconButton(
              onPressed: () async {
                PromptEmailChatBox.promptEmailController.text = idea;
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 16,)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context);

    return emailProvider.suggestIdeas == null ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("You don't have any idea to reply? ", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 100, 116, 139)),),
        TextButton(
          onPressed: () async {
            if (!emailProvider.isLoadingSuggestIdeas) {
              if (widget.receivedEmailController.text == "") {
                Fluttertoast.showToast(
                  msg: "Received email should not be empty!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 20.0,
                );
              } else {
                emailProvider.getSuggestIdeas(
                    widget.receivedEmailController.text);
              }
            }
          },
          child: !emailProvider.isLoadingSuggestIdeas ?
          Text("Get suggestions", style: TextStyle(fontSize: 13, color: Colors.blue),) :
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                width: 17,
                height: 17,
                child: CircularProgressIndicator()
              ),
            )
          ),
        )
      ],
    ) : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Reply suggestions', style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.bold),),
              IconButton(
                onPressed: () async {
                  if (!emailProvider.isLoadingSuggestIdeas) {
                    if (widget.receivedEmailController.text == "") {
                      Fluttertoast.showToast(
                        msg: "Received email should not be empty!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 20.0,
                      );
                    } else {
                      emailProvider.getSuggestIdeas(
                          widget.receivedEmailController.text);
                    }
                  }
                },
                icon: !emailProvider.isLoadingSuggestIdeas ? Icon(Icons.refresh) :
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 17,
                      height: 17,
                      child: CircularProgressIndicator()
                    ),
                  )
                ),
              )
            ],
          ),
        ),
        ...emailProvider.suggestIdeas!.ideas.map((idea) => _buildSuggestIdeasItem(idea)).toList()
      ]
    );
  }
}
