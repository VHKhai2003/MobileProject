import 'package:code/views/profile/about/AboutLabel.dart';
import 'package:code/views/profile/about/MoreFromJarvis.dart';
import 'package:code/views/profile/about/PrivacyPolicy.dart';
import 'package:code/views/profile/about/Version.dart';
import 'package:code/views/profile/account/AccountInfo.dart';
import 'package:code/views/profile/account/AccountLabel.dart';
import 'package:code/views/profile/account/Login.dart';
import 'package:code/views/profile/buttons/DeleteAccountButton.dart';
import 'package:code/views/profile/buttons/LogoutButton.dart';
import 'package:code/views/profile/support/JarvisPlayground.dart';
import 'package:code/views/profile/support/Setting.dart';
import 'package:code/views/profile/support/SupportLabel.dart';
import 'package:code/views/profile/token-usage/TokenUsage.dart';
import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.isAuthenticated});
  final bool isAuthenticated;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          title: const Text("Profile",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          children: [
            const TokenUsage(),
            const SizedBox(height: 10),
            const AccountLabel(),
            if (isAuthenticated) ...[
              const AccountInfo(),
              const LogoutButton(),
            ] else ...[
              const Login(),
            ],
            const SizedBox(height: 10),
            const SupportLabel(),
            const Setting(),
            const JarvisPlayground(),
            const SizedBox(
              height: 10,
            ),
            const AboutLabel(),
            const PrivacyPolicy(),
            const Version(),
            const MoreFromJarvis(),
            if (isAuthenticated) ...[
              const SizedBox(height: 15),
              const DeleteAccountButton()
            ]
          ],
        ),
      ),
    );
  }
}
