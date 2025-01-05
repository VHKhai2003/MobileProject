import 'package:code/features/ai-action/providers/EmailProvider.dart';
import 'package:code/features/ai-action/providers/EmailStyleProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PromptEmailChatBox extends StatelessWidget {
  const PromptEmailChatBox({super.key, required this.receivedEmailController});
  final TextEditingController receivedEmailController;
  static TextEditingController promptEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailStyleProvider = Provider.of<EmailStyleProvider>(context);
    final emailProvider = Provider.of<EmailProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: TextField(
              controller: promptEmailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(242, 243, 250, 1),
                hintText: "Tell EchoAI how you want to reply...",
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
                suffixIcon: IconButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (receivedEmailController.text == "") {
                      Fluttertoast.showToast(
                        msg: "Received email should not be empty!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 20.0,
                      );
                    } else {
                      if (promptEmailController.text == "") {
                        promptEmailController.text = "Reply to this email";
                      }
                      emailProvider.setIsDisplayReply(true);
                      emailProvider.setEmailResponse(null);
                      emailProvider.replyEmail(
                        receivedEmailController.text,
                        promptEmailController.text,
                        promptEmailController.text,
                        emailStyleProvider.length.toLowerCase(),
                        emailStyleProvider.formality.toLowerCase(),
                        emailStyleProvider.tone.toLowerCase()
                      );
                      promptEmailController.clear();
                    }
                  },
                  icon: const Icon(Icons.send)
                )
              ),
            ),
          ),
          const SizedBox(width: 10,),
          // const Expanded(
          //     flex: 1,
          //     child: Text('data')
          // )
        ],
      ),
    );
  }
}
