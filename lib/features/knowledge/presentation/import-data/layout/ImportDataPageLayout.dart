import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';

class ImportDataPageLayout extends StatelessWidget {
  const ImportDataPageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        title: const Text("Add unit", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: buildActions(context),
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
    );
  }
}
