import 'package:code/features/auth/presentation/components/JarvisLogoAndLabel.dart';
import 'package:code/features/upgrade/presentation/cards/basic-card/BasicCard.dart';
import 'package:code/features/upgrade/presentation/cards/pro-card/ProCard.dart';
import 'package:code/features/upgrade/presentation/cards/starter-card/StarterCard.dart';
import 'package:code/features/upgrade/presentation/components/Commitment.dart';
import 'package:code/features/upgrade/presentation/components/Introduction.dart';
import 'package:flutter/material.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color(0xFFEBEFFF),
          leading: IconButton(
              onPressed: () { Navigator.of(context).pop(); },
              icon: const Icon(Icons.arrow_back, size: 25, color: Colors.grey,)
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 30),
          children: [
            JarvisLogoAndLabel(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            Introduction(),
            SizedBox(height: 10),
            BasicCard(),
            SizedBox(height: 40),
            StarterCard(),
            SizedBox(height: 40),
            ProCard(),
            SizedBox(height: 40),
            Commitment()
          ],
        )
    );
  }
}