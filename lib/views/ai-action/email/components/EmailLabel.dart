import 'package:flutter/material.dart';

class EmailLabel extends StatelessWidget {
  const EmailLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.email, size: 50, color: Colors.blueGrey,),
            Text(
              "Email",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            Text(
              "Give an asking for help email template",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}
