import 'package:code/features/upgrade/presentation/cards/components/AdvancedFeatures.dart';
import 'package:code/features/upgrade/presentation/cards/components/BasicFeatures.dart';
import 'package:code/features/upgrade/presentation/cards/components/MoreQueriesPerMonth.dart';
import 'package:code/features/upgrade/presentation/cards/components/OtherBenefits.dart';
import 'package:code/features/upgrade/presentation/cards/pro-card/header/ProCardHeader.dart';
import 'package:flutter/material.dart';

class ProCard extends StatelessWidget {
  const ProCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bo góc của viền
            side: const BorderSide(
              color: Color.fromRGBO(238, 193, 81, 1), // Màu viền
              width: 2, // Độ dày của viền
            ),
          ),
          elevation: 10, // Độ cao của đổ bóng
          shadowColor: Color.fromRGBO(238, 193, 81, 1), // Màu của bóng
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProCardHeader(),
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
        ),
        Positioned(
          top: -40,
          right: -40,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              'assets/icons/hot-pick.png',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            )
          ),
        ),
      ],
    );
  }
}
