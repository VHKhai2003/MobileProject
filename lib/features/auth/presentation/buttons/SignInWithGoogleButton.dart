import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        // authProvider.getGoogleAuthToken();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipOval(
              child: Image.asset(
                'assets/icons/google-icon.png',
                width: 15,
                height: 15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Sign in with Google',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
