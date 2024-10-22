import 'package:code/views/upgrade/cards/components/AdvancedFeatures.dart';
import 'package:code/views/upgrade/cards/components/BasicFeatures.dart';
import 'package:code/views/upgrade/cards/components/MoreQueriesPerMonth.dart';
import 'package:code/views/upgrade/cards/components/OtherBenefits.dart';
import 'package:code/views/upgrade/cards/starter-card/header/StarterCardHeader.dart';
import 'package:flutter/material.dart';

class StarterCard extends StatelessWidget {
  const StarterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bo góc của viền
        side: BorderSide(
          color: Colors.blue, // Màu viền
          width: 2, // Độ dày của viền
        ),
      ),
      elevation: 10, // Độ cao của đổ bóng
      shadowColor: Colors.blue, // Màu của bóng
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StarterCardHeader(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            BasicFeatures(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            MoreQueriesPerMonth(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            AdvancedFeatures(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            OtherBenefits(),
          ],
        ),
      ),
    );
  }
}
