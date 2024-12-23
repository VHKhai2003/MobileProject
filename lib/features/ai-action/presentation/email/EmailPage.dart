import 'package:code/features/ai-action/presentation/email/components/EmailLabel.dart';
import 'package:code/features/ai-action/presentation/email/components/JarvisReply.dart';
import 'package:code/features/ai-action/presentation/email/components/ReceivedEmail.dart';
import 'package:code/features/ai-action/presentation/email/components/Suggestions.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context, listen: false);

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
              icon: const Icon(Icons.arrow_back, size: 25, color: Colors.grey,)
          ),
          actions: buildActions(context, tokenUsageProvider.tokenUsage),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
