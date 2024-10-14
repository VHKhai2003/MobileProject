import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.onChangePassword});
  final Function(bool) onChangePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
          onPressed: () {onChangePassword(false);},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
      ),
    );
  }
}
