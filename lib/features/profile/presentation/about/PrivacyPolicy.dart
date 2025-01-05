import 'package:code/core/constants/ApiConstants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.policy, color: Colors.blue),
        title: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          const url = ApiConstants.privacyUrl;
          final Uri uri = Uri.parse(url);
          await launchUrl(uri);
        },
      ),
    );
  }
}
