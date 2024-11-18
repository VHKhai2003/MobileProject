import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/models/Unit.dart';
import 'package:code/features/knowledge/models/UnitTypeName.dart';
import 'package:code/shared/widgets/appbar/BuildActions.dart';
import 'package:code/features/knowledge/presentation/units/components/AddUnitButton.dart';
import 'package:code/features/knowledge/presentation/units/components/KnowledgeInfo.dart';
import 'package:code/features/knowledge/presentation/units/components/UnitElement.dart';
import 'package:flutter/material.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key, required this.knowledge, required this.editKnowledge});
  final Knowledge knowledge;
  final Function(Knowledge) editKnowledge;

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late Knowledge knowledge;

  static List<UnitElement> items = [
    UnitElement(unit: Unit(DateTime.now().millisecondsSinceEpoch.toString(), "Unit1", UnitTypeName.local, 231, "10/10/2024", true)),
    UnitElement(unit: Unit(DateTime.now().millisecondsSinceEpoch.toString(), "Unit2", UnitTypeName.slack, 123, "24/09/2024", false)),
    UnitElement(unit: Unit(DateTime.now().millisecondsSinceEpoch.toString(), "Unit3", UnitTypeName.drive, 95, "24/10/2024", false)),
    UnitElement(unit: Unit(DateTime.now().millisecondsSinceEpoch.toString(), "Unit4", UnitTypeName.website, 241, "16/10/2024", true)),
    UnitElement(unit: Unit(DateTime.now().millisecondsSinceEpoch.toString(), "Unit5", UnitTypeName.confluence, 147, "21/10/2024", true)),
  ];

  @override
  void initState() {
    super.initState();
    knowledge = widget.knowledge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        title: const Text("Units", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: buildActions(context),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KnowledgeInfo(knowledge: knowledge, editKnowledge: widget.editKnowledge),
                    AddUnitButton()
                  ],
                ),
              ),
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
                  "Add a unit to store your data.",
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
    );
  }
}
