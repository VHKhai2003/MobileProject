import 'package:flutter/material.dart';

class KnowledgeDropDownTable extends StatefulWidget {
  @override
  _KnowledgeDropDownTableState createState() => _KnowledgeDropDownTableState();
}

class _KnowledgeDropDownTableState extends State<KnowledgeDropDownTable> {
  final List<String> knowledgeList = [
    'Knowledge 1',
    'Knowledge 2',
    'Knowledge 3',
    'Knowledge 4',
    'Knowledge 5',
  ];

  String? selectedKnowledge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          hint: Text('Choose your knownledge'),
          value: selectedKnowledge,
          onChanged: (String? newValue) {
            setState(() {
              selectedKnowledge = newValue;
            });
          },
          items: knowledgeList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          selectedKnowledge != null
              ? 'Your knowledge: $selectedKnowledge'
              : 'Choose knowledge !! I will help you answer about it ',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
