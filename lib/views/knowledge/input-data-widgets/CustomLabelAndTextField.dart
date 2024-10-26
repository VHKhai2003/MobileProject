import 'package:flutter/material.dart';

class CustomLabelAndTextField extends StatelessWidget {
  const CustomLabelAndTextField({super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('*', style: TextStyle(color: Colors.red),),
              Text(' $label:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 6,),
          TextField(
            controller: controller,
            style: const TextStyle(
                fontSize: 14
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 0.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 0.7),
              ),
              hoverColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
