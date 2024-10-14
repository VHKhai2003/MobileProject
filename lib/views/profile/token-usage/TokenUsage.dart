import 'package:flutter/material.dart';
import 'package:code/views/profile/token-usage/TokenUsageIndicator.dart';


class TokenUsage extends StatelessWidget {
  const TokenUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEBEFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Token Usage", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            TokenUsageWidget(totalTokens: 30, usedTokens: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10"),
                Text("30")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
