import 'package:flutter/material.dart';

class JarvisLogoAndLabel extends StatelessWidget {
  const JarvisLogoAndLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: ClipOval(
            child: Image.asset(
              'assets/icons/jarvis-icon.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Text(
          'Jarvis',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(20, 80, 163, 1)
          ),
        ),
      ],
    );
  }
}
