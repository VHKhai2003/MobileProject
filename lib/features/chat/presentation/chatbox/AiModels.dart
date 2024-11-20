import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:code/features/chat/models/AiAgent.dart';
import 'package:provider/provider.dart';

List<AiAgent> agents = [
  AiAgent.gpt_4o_mini,
  AiAgent.gpt_4o,
  AiAgent.gemini_15_flash,
  AiAgent.gemini_15_pro,
  AiAgent.claude_3_haiku,
  AiAgent.claude_35_sonnet,
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
    final aiModelProvider = Provider.of<AiModelProvider>(context, listen: false);

    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100
      ),
      child: DropdownButton<String>(
          items: agents.map((agent) {
              return DropdownMenuItem<String>(value: agent.name, child: _buildDropdownItem(agent));
            }).toList(),
          onChanged: (String? value) {
            aiModelProvider.setAiAgent(AiAgent.findByName(value!)!);
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





