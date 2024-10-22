import 'package:flutter/material.dart';

class MoreQueriesPerMonth extends StatelessWidget {
  const MoreQueriesPerMonth({super.key});

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
                'More queries per month',
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
                    '50 free queries per day',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
