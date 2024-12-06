import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({super.key, this.hinText = '', this.maxLines = 1, required this.controller});

  final String hinText;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14
      ),
      decoration: InputDecoration(
        hintText: hinText,
        filled: true,
        fillColor: Colors.blueGrey.shade50,
        hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // don't have outline when unfocus
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 0.7)
        ),
        hoverColor: Colors.transparent,
      ),
      controller: controller,
      maxLines: maxLines,
    );
  }
}
