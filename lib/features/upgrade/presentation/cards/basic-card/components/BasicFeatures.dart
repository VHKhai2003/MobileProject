import 'package:flutter/material.dart';

class BasicFeatures extends StatelessWidget {
  const BasicFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Basic features',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                ),
                Expanded(
                  child: Text(
                    'AI Chat Models',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Text(
                'GPT-3.5',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                ),
                Expanded(
                  child: Text(
                    'AI Action Injection',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                ),
                Expanded(
                  child: Text(
                    'Select Text for AI Action',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
