import 'package:code/features/ai-action/presentation/components/ActionWithName.dart';
import 'package:code/features/ai-action/presentation/components/SearchBox.dart';
import 'package:code/features/ai-action/presentation/email/EmailPage.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart' as navigation_drawer;
import 'package:provider/provider.dart';

class AIActionPage extends StatelessWidget {
  const AIActionPage({super.key});

  static const List<ActionWithName> items = [
    ActionWithName(
        actionName: "Email",
        actionIcon: Icons.mail,
        actionDescription: "Give an asking for help email template",
        selectedAction: EmailPage()),
  ];

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          title: const Text("AI Action",
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: buildActions(context, tokenUsageProvider.tokenUsage),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
            )),
      ),
    );
  }
}
