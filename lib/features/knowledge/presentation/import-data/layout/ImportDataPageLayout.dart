import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/providers/ImportDataProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportDataPageLayout extends StatelessWidget {
  const ImportDataPageLayout({super.key, required this.child, required this.knowledge});

  final Widget child;
  final Knowledge knowledge;

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => ImportDataProvider(knowledge: knowledge),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEBEFFF),
          title: const Text("Add unit", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: buildActions(context, tokenUsageProvider.tokenUsage),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                )
              ],
            ),
            width: 320,
            child: child,
          ),
        ),
      ),
    );
  }
}
