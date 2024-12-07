import 'package:flutter/material.dart';

class StyleButton extends StatefulWidget {
  const StyleButton({super.key, required this.icon, required this.label, required this.value, required this.onChange});
  final String icon;
  final String label;
  final String value;
  final Function(String) onChange;

  @override
  State<StyleButton> createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {
        if (widget.label != widget.value) {
          widget.onChange(widget.label);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        backgroundColor: widget.label == widget.value ? Colors.blue.shade100 : null,
        side: widget.label == widget.value ? BorderSide(
          color: Colors.blue.shade500,
          width: 1,
        ) : BorderSide.none,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.icon,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Text(widget.label, style: const TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
