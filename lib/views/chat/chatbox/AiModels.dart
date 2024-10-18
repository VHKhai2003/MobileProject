import 'package:flutter/material.dart';
import 'package:code/models/AiAgent.dart';

List<AiAgent> agents = [
  AiAgent("GPT-4o mini", 'assets/icons/gpt-4o-mini.png', 1),
  AiAgent("GPT-4o", 'assets/icons/gpt-4o.png', 5),
  AiAgent("Gemini 1.5 Flash", 'assets/icons/gemini-15-flash.webp', 1),
  AiAgent("Gemini 1.5 Pro", 'assets/icons/gemini-15-pro.png', 2),
  AiAgent("Clause 3 Haiku", 'assets/icons/claude-3-haiku.jpg', 3),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                  agent.image,
                width: 20, height: 20,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 4),
            Text(agent.name),
          ],
        ),
        Row(
          children: [
            Text(agent.token.toString()),
            Icon(Icons.local_fire_department, color: Colors.blue.shade600,)
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
              return SizedBox(
                width: 200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              agent.image,
                              width: 20, height: 20,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(agent.name),
                        ],
                      ),
                      Row(
                        children: [
                          Text(agent.token.toString()),
                          Icon(Icons.local_fire_department_rounded, color: Colors.blue.shade600,)
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





