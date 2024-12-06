import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextRegister extends StatelessWidget {
  const RichTextRegister({super.key, required this.updateState});
  final Function(String) updateState;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.grey,
                  )
              ),
              TextSpan(
                  text: "Register",
                  style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {updateState("Register");}
              ),
            ]
        )
    );
  }
}
