import 'package:code/features/ai-action/presentation/email/email-style/components/StyleButton.dart';
import 'package:flutter/material.dart';

class Tone extends StatefulWidget {
  const Tone({super.key, required this.tone, required this.onChange});
  final String tone;
  final Function(String) onChange;

  @override
  State<Tone> createState() => _ToneState();
}

class _ToneState extends State<Tone> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tones = [
      StyleButton(icon: 'assets/icons/thanks.png', label: 'Witty', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/sorry.png', label: 'Direct', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/like.png', label: 'Personable', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/dislike.png', label: 'Informational', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/followup.png', label: 'Friendly', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Confident', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Sincere', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Enthusiastic', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Optimistic', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Concerned', value: widget.tone, onChange: widget.onChange,),
      StyleButton(icon: 'assets/icons/confused.png', label: 'Empathetic', value: widget.tone, onChange: widget.onChange,),
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.emoji_emotions_outlined),
              SizedBox(width: 10,),
              Text("Tone", style: TextStyle(
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
