import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/UpdateButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Widget> buildActions(BuildContext context, int tokenUsage) {
  final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);
  if(tokenUsageProvider.tokenUsageModel.unlimited) {
    return [
      Row(
        children: [
          Text(
            'Pro',
            style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          const SizedBox(width: 4),
          Icon(Icons.workspace_premium, color: Colors.blue.shade700, size: 20),
        ],
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
        child: Row(
          children: [
            Text(
              'Unlimited',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(width: 5),
            Image(
              image: AssetImage('assets/icons/fire.png'),
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    ];
  }
  return [
    UpdateButton(),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Row(
        children: [
          Text(
            '$tokenUsage',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(width: 5),
          Image(
            image: AssetImage('assets/icons/fire.png'),
            width: 20,
            height: 20,
          ),
        ],
      ),
    ),
  ];
}
