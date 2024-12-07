import 'package:code/features/ai-action/presentation/email/components/EmailLabel.dart';
import 'package:code/features/ai-action/presentation/email/components/JarvisReply.dart';
import 'package:code/features/ai-action/presentation/email/components/ReceivedEmail.dart';
import 'package:code/features/ai-action/presentation/email/components/promptEmailChatBox.dart';
import 'package:code/features/ai-action/presentation/email/email-style/EmailStyle.dart';
import 'package:code/features/ai-action/providers/EmailProvider.dart';
import 'package:code/features/ai-action/providers/EmailStyleProvider.dart';
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
  final TextEditingController receivedEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmailStyleProvider()),
        ChangeNotifierProvider(create: (context) => EmailProvider(context.read<TokenUsageProvider>())),

      ],
      child: GestureDetector(
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
                    children: [
                      const EmailLabel(),
                      ReceivedEmail(receivedEmailController: receivedEmailController,),
                      const SizedBox(height: 15),
                      const EmailStyle(),
                      const SizedBox(height: 15),
                      const JarvisReply(),
                    ],
                  ),
                ),
                PromptEmailChatBox(receivedEmailController: receivedEmailController,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
