import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:flutter/material.dart';
import 'package:code/features/profile/presentation/token-usage/TokenUsageIndicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenUsage extends StatefulWidget {
  const TokenUsage({super.key});

  @override
  State<TokenUsage> createState() => _TokenUsageState();
}

class _TokenUsageState extends State<TokenUsage> with WidgetsBindingObserver{
  Future<void> redirectTo(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("Application comes from background!");
      // call getUsage here to update status
      // final tokenUsageProvider = Provider.of<TokenUsageProvider>(context, listen: false);
      // tokenUsageProvider.getUsage1();
    } else if (state == AppLifecycleState.paused) {
      print("Application is paused");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);
    
    List<Widget> widgets = [];
    
    if(tokenUsageProvider.tokenUsageModel.unlimited) {
      widgets = [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("Token Usage", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/icons/fire.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            Text('Unlimited', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade700),),
          ],
        ),
      ];
    }
    else {
      widgets = [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("Token Usage", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/icons/fire.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                redirectTo(ApiConstants.upgradeUrl);
              },
              child: Row(
                children: [
                  Text('Upgrade', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(width: 4,),
                  Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 25)
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Total", style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        TokenUsageWidget(totalTokens: tokenUsageProvider.tokenUsageModel.totalTokens, usedTokens: tokenUsageProvider.tokenUsage),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${tokenUsageProvider.tokenUsage}"),
            Text("${tokenUsageProvider.tokenUsageModel.totalTokens}")
          ],
        ),
      ];
    }
    
    return Card(
      color: const Color(0xFFEBEFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ),
    );
  }
}
