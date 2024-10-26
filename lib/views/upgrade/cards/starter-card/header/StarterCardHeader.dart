import 'package:code/views/upgrade/button/SubscribeStarterButton.dart';
import 'package:flutter/material.dart';

class StarterCardHeader extends StatelessWidget {
  const StarterCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: ClipOval(
                  child: Image.asset(
                    'assets/icons/infinity.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'Starter',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
              '1-month Free Trial',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(67, 106, 175, 1)
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Then',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '\$9.99/month',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SubscribeStarterButton()
          ),
        ],
      ),
    );
  }
}
