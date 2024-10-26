import 'package:code/views/upgrade/button/SubscribeProButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProCardHeader extends StatelessWidget {
  const ProCardHeader({super.key});

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
                    'assets/icons/pro.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'Pro Annually',
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
                '\$79.99/year',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(31, 63, 126, 1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.gift_fill, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    'Save 33% on annual plan!'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(30),
              child: SubscribeProButton()
          ),
        ],
      ),
    );
  }
}
