import 'package:code/views/appbar/BuildActions.dart';
import 'package:code/views/knowledge/components/CreateKnowledgeButton.dart';
import 'package:code/views/knowledge/components/KnowledgeElement.dart';
import 'package:code/views/knowledge/components/SearchBox.dart';
import 'package:flutter/material.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  static const List<KnowledgeElement> items = [
    KnowledgeElement(
      name: "Knowledge1",
      unit: 0,
      byte: 0,
      date: "23/10/2024",
      isEnable: true,
    ),
    KnowledgeElement(
      name: "Knowledge2",
      unit: 2,
      byte: 240,
      date: "20/10/2024",
      isEnable: true,
    ),
    KnowledgeElement(
      name: "Knowledge3",
      unit: 1,
      byte: 320,
      date: "15/10/2024",
      isEnable: false,
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
          title: const Text("Knowledge", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: buildActions(context),
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
                CreateKnowledgeButton(),
                if (items.isEmpty) ...[
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/icons/empty-box.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text("No data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                    "Create a knowledge base to store your data and manage your units.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return items[index];
                      },
                      // padding: const EdgeInsets.all(10),
                    ),
                  ),
                ]

              ],
            )
        ),
      ),
    );
  }
}
