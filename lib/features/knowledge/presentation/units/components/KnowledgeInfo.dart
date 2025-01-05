import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/units/dialog/EditKnowledgeDialog.dart';
import 'package:code/features/knowledge/providers/UnitProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KnowledgeInfo extends StatefulWidget {
  const KnowledgeInfo({super.key});

  @override
  State<KnowledgeInfo> createState() => _KnowledgeInfoState();
}

class _KnowledgeInfoState extends State<KnowledgeInfo> {
  @override
  Widget build(BuildContext context) {
    UnitProvider unitProvider = Provider.of<UnitProvider>(context);
    Knowledge knowledge = unitProvider.knowledge;
    return Row(
      children: [
        Image.asset(
          'assets/icons/knowledge-base.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                        knowledge.knowledgeName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(onPressed: () {
                    showDialog(context: context, builder: (context) => EditKnowledgeDialog(unitProvider: unitProvider));
                  }, icon: Icon(Icons.edit_outlined)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue[50], // Màu nền của Container
                      border: Border.all(
                        color: Colors.blueAccent, // Màu của viền (border)
                        width: 1, // Độ dày của viền
                      ),
                      borderRadius: BorderRadius.circular(10), // Bo góc của viền
                    ),
                    child: Text(
                      "${knowledge.numUnits} ${knowledge.numUnits == 1 ? 'unit' : 'units'}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue[700]
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red[50], // Màu nền của Container
                      border: Border.all(
                        color: Colors.redAccent, // Màu của viền (border)
                        width: 1, // Độ dày của viền
                      ),
                      borderRadius: BorderRadius.circular(10), // Bo góc của viền
                    ),
                    child: Text(
                      "${(knowledge.totalSize / 1024).toStringAsFixed(2)} KB",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.red[700]
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
