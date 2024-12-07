import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:flutter/material.dart';

class KnowledgeInfo extends StatefulWidget {
  const KnowledgeInfo({super.key, required this.knowledge, required this.editKnowledge});
  final Knowledge knowledge;
  final Function(Knowledge) editKnowledge;
  @override
  State<KnowledgeInfo> createState() => _KnowledgeInfoState();
}

class _KnowledgeInfoState extends State<KnowledgeInfo> {
  late Knowledge knowledge;

  @override
  void initState() {
    super.initState();
    knowledge = widget.knowledge;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/knowledge-base.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                knowledge.knowledgeName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                )
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        )
      ],
    );
  }
}
