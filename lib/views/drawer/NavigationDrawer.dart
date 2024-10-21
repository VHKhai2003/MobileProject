import 'package:flutter/material.dart';
import 'package:code/views/auth/LoginPage.dart';
import 'package:code/views/profile/ProfilePage.dart';
import 'package:code/views/ai-action/AIAction.dart';
import 'package:code/views/chat/ChatPage.dart';
import 'package:code/views/bot/MainBot.dart';

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
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: transitionsBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  icon: const Icon(Icons.close, size: 16),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(const ChatPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Ai Action',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(const AIAction());
            },
          ),
          ListTile(
            leading: const Icon(Icons.smart_toy),
            title: const Text('Bot',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(Mainbot());
            },
          ),
          ListTile(
            leading: const Icon(Icons.smart_toy),
            title: const Text('Knownledge',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(Mainbot());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(const ProfilePage(isAuthenticated: true));
            },
          ),
          const Divider(height: 1, color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Sign in / Sign up',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              _navigateTo(const LoginPage(state: "Login"));
            },
          ),
        ],
      ),
    );
  }
}
