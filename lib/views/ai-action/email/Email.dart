import 'package:code/views/ai-action/email/components/EmailLabel.dart';
import 'package:code/views/ai-action/email/components/JarvisReply.dart';
import 'package:code/views/ai-action/email/components/ReceivedEmail.dart';
import 'package:code/views/ai-action/email/components/Suggestions.dart';
import 'package:code/views/chat/chatbox/ChatBox.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          leading: IconButton(
              onPressed: () { Navigator.of(context).pop(); },
              icon: const Icon(Icons.close, size: 25, color: Colors.grey,)
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
              child: Row(
                children: [
                  const Text('50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/icons/fire.png',
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  children: const [
                    EmailLabel(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Received email", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                    ),
                    ReceivedEmail(),
                    SizedBox(height: 15),
                    JarvisReply(),
                    Suggestions(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                // child: Row(
                //   children: [
                //     Expanded(
                //       flex: 10,
                //       child: TextField(
                //         decoration: InputDecoration(
                //             filled: true,
                //             fillColor: const Color.fromRGBO(242, 243, 250, 1),
                //             hintText: "Tell Jarvis how you want to reply...",
                //             hintStyle: const TextStyle(color: Colors.grey),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide: const BorderSide(color: Colors.grey, width: 1),
                //             ),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide: const BorderSide(color: Colors.grey, width: 1),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
                //             ),
                //             suffixIcon: IconButton(
                //                 color: Colors.blue,
                //                 onPressed: () {  },
                //                 icon: const Icon(Icons.send)
                //             )
                //         ),
                //
                //       ),
                //     ),
                //     const SizedBox(width: 10,),
                //     const Expanded(
                //         flex: 1,
                //         child: Text('data')
                //     )
                //   ],
                // ),
                child: Chatbox(openNewChat: () {}, changeConversation: (){},),
              )
            ],
          ),
        ),
      ),
    );
  }
}
