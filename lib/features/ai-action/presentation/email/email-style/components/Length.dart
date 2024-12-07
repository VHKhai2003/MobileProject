import 'package:code/features/ai-action/presentation/email/email-style/components/StyleButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  const Length({super.key, required this.length, required this.onChange});
  final String length;
  final Function(String) onChange;
  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  @override
  Widget build(BuildContext context) {
    List<Widget> lengths = [
      StyleButton(icon: 'assets/icons/thanks.png', label: 'Short', value: widget.length, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/sorry.png', label: 'Medium', value: widget.length, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/like.png', label: 'Long', value: widget.length, onChange: widget.onChange,),
    ];
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(CupertinoIcons.doc_text),
                SizedBox(width: 10,),
                Text("Length", style: TextStyle(
                  fontSize: 18,
                )),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 0,
            children: lengths,
          ),
        ]
    );
  }
}
