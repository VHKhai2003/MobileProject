import 'package:code/features/ai-action/presentation/email/email-style/components/Formality.dart';
import 'package:code/features/ai-action/presentation/email/email-style/components/Length.dart';
import 'package:code/features/ai-action/presentation/email/email-style/components/Tone.dart';
import 'package:code/features/ai-action/providers/EmailStyleProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailStyle extends StatefulWidget {
  const EmailStyle({super.key});

  @override
  State<EmailStyle> createState() => _EmailStyleState();
}

class _EmailStyleState extends State<EmailStyle> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final emailStyleProvider = Provider.of<EmailStyleProvider>(context);
    String length = emailStyleProvider.length;
    String formality = emailStyleProvider.formality;
    String tone = emailStyleProvider.tone;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Email style", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isOpen = !_isOpen;
                  });
                },
                icon: Icon( _isOpen ? Icons.expand_less : Icons.expand_more)
            )
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            children: [
              if (_isOpen) ...[
                Length(length: length, onChange: emailStyleProvider.setLength,),
                SizedBox(height: 10,),
                Formality(formality: formality, onChange: emailStyleProvider.setFormality,),
                SizedBox(height: 10,),
                Tone(tone: tone, onChange: emailStyleProvider.setTone,),
              ]
            ],
          ),
        )
      ],
    );
  }
}
