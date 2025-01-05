import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/components/ListKnowledge.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:code/features/knowledge/presentation/components/KnowledgeElement.dart';
import 'package:flutter/material.dart';
import 'package:code/shared/widgets/drawer/NavigationDrawer.dart'
    as navigation_drawer;
import 'package:provider/provider.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  static List<KnowledgeElement> items = [];
  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => KnowledgeProvider(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFFEBEFFF),
            title: const Text("Knowledge",
                style: TextStyle(fontWeight: FontWeight.bold)),
            actions: buildActions(context, tokenUsageProvider.tokenUsage),
          ),
          drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
          body: ListKnowledge(),
        ),
      ),
    );
  }
}
