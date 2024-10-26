import 'package:flutter/material.dart';

class OtherBenefits extends StatelessWidget {
  const OtherBenefits({super.key});

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
                'Other benefits',
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
                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                ),
                Expanded(
                  child: Text(
                    'No request limits during high-traffic',
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
                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                ),
                Expanded(
                  child: Text(
                    '2X faster response speed',
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
                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                ),
                Expanded(
                  child: Text(
                    'Priority email support',
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
