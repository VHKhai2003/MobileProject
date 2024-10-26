import 'package:flutter/material.dart';

class SaveChangeButton extends StatelessWidget {
  const SaveChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey, width: 2)
      ),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
      ),
    );
  }
}
