import 'package:code/views/ai-action/components/ActionWithName.dart';
import 'package:code/views/ai-action/components/SearchBox.dart';
import 'package:code/views/ai-action/email/Email.dart';
import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;

class AIAction extends StatelessWidget {
  const AIAction({super.key});

  static const List<ActionWithName> items = [
    ActionWithName(
      actionName: "Email",
      actionIcon: Icons.mail,
      actionDescription: "Give an asking for help email template",
      selectedAction: Email()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          title: const Text("AI Action", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
              child: Row(
                children: [
                  const Text('50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/icons/fire.png',
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
        drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SearchBox(),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return items[index];
                  },
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
