import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/units/components/ListUnits.dart';
import 'package:code/features/knowledge/providers/UnitProvider.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key, required this.knowledge});
  final Knowledge knowledge;

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late Knowledge knowledge;

  @override
  void initState() {
    super.initState();
    knowledge = widget.knowledge;
  }

  @override
  Widget build(BuildContext context) {
    final tokenUsageProvider = Provider.of<TokenUsageProvider>(context);

    return ChangeNotifierProvider(
        create: (context) => UnitProvider(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFEBEFFF),
            title: const Text("Units", style: TextStyle(fontWeight: FontWeight.bold)),
            actions: buildActions(context, tokenUsageProvider.tokenUsage),
          ),
          body: ListUnits(knowledge: knowledge),
        ),
    );
  }
}
