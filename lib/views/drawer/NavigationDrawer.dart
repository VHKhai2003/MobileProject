import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
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
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.android, color: Colors.blue,),
                      SizedBox(width: 10),
                      Text(
                        'Jarvis15',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () { Navigator.of(context).pop();}, icon: const Icon(Icons.close, size: 16,))
                ],
              ),
            ),

          const Divider(height: 1, color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: () {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (context) => ChatPage()),);
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessibility_new),
            title: const Text('Ai Action', style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => AiAction()),);
            }
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfilePage()),);
            },
          ),
          const Divider(height: 1, color: Colors.grey,),

          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Sign in / Sign up', style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
