import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  const Field({super.key, required this.fieldName, required this.controller, required this.focusNode, required this.focusNodeNext});

  final String fieldName;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? focusNodeNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( fieldName, style: const TextStyle(fontSize: 15)),
        const SizedBox(
          height: 2,
        ),
        TextField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: Colors.indigoAccent,
          decoration: InputDecoration(
            hintText: 'Enter your ${fieldName.toLowerCase()}',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFEBEFFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.indigoAccent, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          ),
          onSubmitted: (value) {
            focusNodeNext == null ? FocusScope.of(context).unfocus() :
              FocusScope.of(context).requestFocus(focusNodeNext);
          },
        ),
      ],
    );
  }

}