import 'package:code/features/ai-action/presentation/email/email-style/components/StyleButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Formality extends StatefulWidget {
  const Formality({super.key, required this.formality, required this.onChange});
  final String formality;
  final Function(String) onChange;
  @override
  State<Formality> createState() => _FormalityState();
}

class _FormalityState extends State<Formality> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tones = [
      StyleButton(icon: '🤙', label: 'Casual', value: widget.formality, onChange: widget.onChange,),
      StyleButton(icon: '📄', label: 'Neutral', value: widget.formality, onChange: widget.onChange,),
      StyleButton(icon: '💼', label: 'Formal', value: widget.formality, onChange: widget.onChange,),
    ];
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(CupertinoIcons.briefcase),
                SizedBox(width: 10,),
                Text("Formality", style: TextStyle(
                  fontSize: 18,
                )),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 0,
            children: tones,
          ),
        ]
    );
  }
}
