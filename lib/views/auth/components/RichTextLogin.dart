import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextLogin extends StatelessWidget {
  const RichTextLogin({super.key, required this.updateState});
  final Function(String) updateState;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                  text: "Try out login again? ",
                  style: TextStyle(
                    color: Colors.grey,
                  )
              ),
              TextSpan(
                  text: "Login",
                  style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {updateState("Login");}
              ),
            ]
        )
    );
  }
}
