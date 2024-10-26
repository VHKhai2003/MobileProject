import 'package:flutter/material.dart';

class AdvancedFeatures extends StatelessWidget {
  const AdvancedFeatures({super.key});

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
                'Advanced features',
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
                    'AI Reading Assistant',
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
                    'Real-time Web Access',
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
                    'AI Writing Assistant',
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
                    'AI Pro Search',
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
