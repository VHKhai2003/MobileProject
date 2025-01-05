import 'package:code/core/constants/ApiConstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    ..onTap = () async {
                      const url = ApiConstants.privacyUrl;
                      final Uri uri = Uri.parse(url);
                      await launchUrl(uri);
                    }
              ),
            ]
        )
    );
  }
}
