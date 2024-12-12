import 'package:code/features/ai-action/presentation/AIActionPage.dart';
import 'package:code/features/bot/presentation/MainBot.dart';
import 'package:code/features/chat/presentation/ChatPage.dart';
import 'package:code/features/knowledge/presentation/KnowledgePage.dart';
import 'package:code/features/profile/presentation/ProfilePage.dart';
import 'package:code/features/profile/presentation/buttons/LogoutButton.dart';
import 'package:code/features/profile/presentation/token-usage/TokenUsageIndicator.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  var transitionsBuilder = (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
    const end = Offset.zero; // Kết thúc tại vị trí gốc
    const curve = Curves.easeInOut; // Hiệu ứng chuyển cảnh
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  };

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: transitionsBuilder),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(Icons.android, color: Colors.blue,),
                    ClipOval(
                      child: Image.asset(
                        'assets/icons/jarvis-icon.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Jarvis15',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                    ))
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text(
              'Chat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _navigateTo(const ChatPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.smart_toy_outlined),
            title: const Text(
              'Bot',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _navigateTo(MainBot());
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(
              'Knowledge',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _navigateTo(KnowledgePage());
            },
          ),
          ListTile(
              leading: const Icon(Icons.explore),
              title: const Text(
                'Ai Action',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _navigateTo(const AIActionPage());
              }),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _navigateTo(const ProfilePage(isAuthenticated: true));
            },
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                color: Color(0xFFEBEFFF),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                      children: [
                        Icon(Icons.account_circle_outlined, size: 40,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tokenUsageProvider.currentUserModel.username, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(tokenUsageProvider.currentUserModel.email, style: TextStyle(),),
                          ],
                        )
                      ],
                    ),
                      const Divider(
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          const Text("Token Usage", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/icons/fire.png',
                            width: 15,
                            height: 15,
                          ),
                        ],
                      ),
                      tokenUsageProvider.tokenUsageModel.unlimited
                          ? TokenUsageWidget(totalTokens: 1, usedTokens: 1)
                          : TokenUsageWidget(totalTokens: tokenUsageProvider.tokenUsageModel.totalTokens, usedTokens: tokenUsageProvider.tokenUsage),
                      tokenUsageProvider.tokenUsageModel.unlimited
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Unlimited")
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${tokenUsageProvider.tokenUsage}"),
                                Text("${tokenUsageProvider.tokenUsageModel.totalTokens}")
                              ],
                            ),
                    ],
                  ),
                ),
              )
          ),
          LogoutButton()
        ],
      ),
    );
  }
}
