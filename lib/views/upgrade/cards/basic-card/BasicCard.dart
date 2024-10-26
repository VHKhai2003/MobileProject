import 'package:code/views/upgrade/cards/basic-card/header/BasicCardHeader.dart';
import 'package:code/views/upgrade/cards/basic-card/components/AdvancedFeatures.dart';
import 'package:code/views/upgrade/cards/basic-card/components/BasicFeatures.dart';
import 'package:code/views/upgrade/cards/basic-card/components/MoreQueriesPerMonth.dart';
import 'package:code/views/upgrade/cards/basic-card/components/OtherBenefits.dart';
import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bo góc của viền
        side: BorderSide(
          color: Colors.grey, // Màu viền
          width: 2, // Độ dày của viền
        ),
      ),
      elevation: 10, // Độ cao của đổ bóng
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BasicCardHeader(),
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
