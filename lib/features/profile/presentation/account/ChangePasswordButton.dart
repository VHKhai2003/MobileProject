import 'package:flutter/material.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key, required this.onChangePassword});
  final Function(bool) onChangePassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey, width: 2)
            ),
            child: ElevatedButton(
                onPressed: () {onChangePassword(true);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Change password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
            ),
          ),
        ),
      ],
    );
  }
}
