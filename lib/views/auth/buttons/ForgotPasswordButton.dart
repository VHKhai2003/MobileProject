import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.onMessageChange});

  final Function(String) onMessageChange;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:() {onMessageChange("Forgot password");},
        child: const Text(
          'Forgot password?',
        )
    );
  }
}
