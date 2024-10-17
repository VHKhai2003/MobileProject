import 'package:flutter/material.dart';
import 'package:code/models/AiAgent.dart';

List<AiAgent> agents = [
  AiAgent("GPT-4o mini", null, 1),
  AiAgent("GPT-4o", null, 5),
  AiAgent("Gemini 1.5 Flash", null, 1),
  AiAgent("Gemini 1.5 Pro", null, 2),
  AiAgent("Clause 3 Haiku", null, 3),
];


class AiModels extends StatefulWidget {
  const AiModels({super.key});

  @override
  State<AiModels> createState() => _AiModelsState();
}

class _AiModelsState extends State<AiModels> {

  String? selectedValue = agents.first.name;

  Widget _buildDropdownItem(AiAgent agent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.android, color: Colors.green),
            const SizedBox(width: 4),
            Text(agent.name.toString()),
          ],
        ),
        Row(
          children: [
            Text(agent.token.toString()),
            const SizedBox(width: 2),
            Image.asset(
              'assets/icons/fire.png',
              width: 20,
              height: 20,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100
      ),
      child: DropdownButton<String>(
          items: agents.map((agent) {
              return DropdownMenuItem<String>(child: _buildDropdownItem(agent), value: agent.name);
            }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          value: selectedValue,
          underline: const SizedBox(), // remove the underline
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 20,
          padding: const EdgeInsets.all(0),
          borderRadius: BorderRadius.circular(16),
          selectedItemBuilder: (BuildContext context) {
            return agents.map((agent) {
              return Container(
                width: 200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8,),
                          const Icon(Icons.android, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(agent.name.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Text(agent.token.toString()),
                          const SizedBox(width: 2),
                          Image.asset(
                            'assets/icons/fire.png',
                            width: 20,
                            height: 20,
                          )
                        ],
                      )
                    ]
                ),
              );
            }).toList();
          },
      ),
    );
  }
}





