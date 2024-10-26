import 'package:code/models/Knowledge.dart';
import 'package:code/views/knowledge/units/dialog/EditKnowledgeDialog.dart';
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

  void editKnowledge(Knowledge k) {
    setState(() {
      knowledge = k;
    });
    widget.editKnowledge(k);
  }

  void _showEditKnowledgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditKnowledgeDialog(editKnowledge: editKnowledge, knowledge: knowledge);
      },
    );
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
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    knowledge.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    )
                ),
                IconButton(onPressed: () {
                  _showEditKnowledgeDialog(context);
                }, icon: Icon(Icons.edit, size: 20))
              ],
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
                    "${knowledge.unit} ${knowledge.unit == 1 ? 'unit' : 'units'}",
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
                    "${knowledge.byte} ${knowledge.byte == 1 ? 'byte' : 'bytes'}",
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
