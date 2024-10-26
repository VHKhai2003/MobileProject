import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                  text: "By continuing, you agree to our ",
                  style: TextStyle(
                    color: Colors.grey,
                  )
              ),
              TextSpan(
                  text: "Privacy policy",
                  style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {}
              ),
            ]
        )
    );
  }
}
