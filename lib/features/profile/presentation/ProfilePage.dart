import 'package:code/features/profile/presentation/about/AboutLabel.dart';
import 'package:code/features/profile/presentation/about/MoreFromJarvis.dart';
import 'package:code/features/profile/presentation/about/PrivacyPolicy.dart';
import 'package:code/features/profile/presentation/about/Version.dart';
import 'package:code/features/profile/presentation/account/AccountInfo.dart';
import 'package:code/features/profile/presentation/account/AccountLabel.dart';
import 'package:code/features/profile/presentation/account/Login.dart';
import 'package:code/features/profile/presentation/buttons/DeleteAccountButton.dart';
import 'package:code/features/profile/presentation/buttons/LogoutButton.dart';
import 'package:code/features/profile/presentation/support/JarvisPlayground.dart';
import 'package:code/features/profile/presentation/support/Setting.dart';
import 'package:code/features/profile/presentation/support/SupportLabel.dart';
import 'package:code/features/profile/presentation/token-usage/TokenUsage.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart' as navigation_drawer;

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
