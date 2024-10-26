import 'package:flutter/material.dart';

class SubscribeStarterButton extends StatelessWidget {
  const SubscribeStarterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromRGBO(70, 139, 222, 1), Color.fromRGBO(116 ,185, 203, 1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Subscribe now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
            ),
          ),
        ),
      ],
    );
  }
}
