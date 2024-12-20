import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/provider/ThreadBotProvider.dart';
import 'package:code/features/chat/presentation/add-assistant/AddAssistantBottomSheet.dart';
import 'package:code/features/chat/providers/AiModelProvider.dart';
import 'package:code/features/chat/providers/ConversationsProvider.dart';
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

List<Bot> bots = [];

List<AiAgent> agentsDisplay = [
  AiAgent.assistant_label,
  AiAgent.assistant_label,
  AiAgent.base_ai_models_label,
  AiAgent.gpt_4o_mini,
  AiAgent.gpt_4o,
  AiAgent.gemini_15_flash,
  AiAgent.gemini_15_pro,
  AiAgent.claude_3_haiku,
  AiAgent.claude_35_sonnet,
];

class AiModels extends StatefulWidget {
  const AiModels({super.key, required this.openNewChat});
  final VoidCallback openNewChat;

  @override
  State<AiModels> createState() => _AiModelsState();
}

class _AiModelsState extends State<AiModels> {

  String? selectedValue = agents.first.name;

  Widget _buildDropdownItem(AiAgent agent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
                agent.image,
              width: 20, height: 20,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              agent.name,
              style: TextStyle(
              color: agent.name == selectedValue ? Colors.lightBlueAccent.shade700 : Colors.black
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> addAssistant() async {
    Bot? bot = await showModalBottomSheet(
        context: context,
        isScrollControlled: true, // lam cho chieu cao bottom sheet > 1/2 man hinh
        builder: (context) {
          return AddAssistantBottomSheet();
        },
        barrierColor: Colors.black.withOpacity(0.2)
    );
    bool isAdded = false;
    if (bot != null && !bots.map((e) {return e.id;}).contains(bot.id)) {
      final aiModelProvider = Provider.of<AiModelProvider>(context, listen: false);
      isAdded = true;
      aiModelProvider.setBot(bot);
      widget.openNewChat();
      bots.add(bot);
      aiModelProvider.setAiAgent(null);
      agentsDisplay.insert(bots.length, AiAgent(bot.id, bot.name, "assets/icons/android.png"));
      selectedValue = bot.name;
    }
    Navigator.of(context).pop();
    return isAdded;
  }

  @override
  Widget build(BuildContext context) {
    final aiModelProvider = Provider.of<AiModelProvider>(context);
    final conversationsProvider = Provider.of<ConversationsProvider>(context);
    final threadBotProvider = Provider.of<ThreadBotProvider>(context);

    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100
      ),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: null,
            enabled: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Assistants",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
          ...bots.map((bot) {
            return DropdownMenuItem<String>(value: bot.name, child: _buildDropdownItem(AiAgent(bot.id, bot.name, "assets/icons/android.png")));
          }),
          DropdownMenuItem<String>(
            value: null,
            enabled: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isAdd = await addAssistant();
                        if (isAdd) {
                          conversationsProvider.setSelectedIndex(-1);
                          threadBotProvider.setSelectedIndex(-1);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blue.shade50
                      ),
                      child: Text('Add Assistant')
                    ),
                  ),
                ],
              )
            ),
          ),
          DropdownMenuItem<String>(
            value: null,
            enabled: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Base AI Models",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
          ...agents.map((agent) {
            return DropdownMenuItem<String>(value: agent.name, child: _buildDropdownItem(agent));
          })
        ],
        onChanged: (String? value) {
          bool stateBefore = aiModelProvider.aiAgent != null;
          Bot? botBefore = aiModelProvider.bot;
          aiModelProvider.setAiAgent(AiAgent.findByName(value!));
          if (aiModelProvider.aiAgent == null) {
            aiModelProvider.setBot(bots.firstWhere((bot) {return bot.name == value;}));
          } else {
            aiModelProvider.setBot(null);
          }
          if (stateBefore != (aiModelProvider.aiAgent != null) || botBefore != (aiModelProvider.bot)) {
            widget.openNewChat();
            conversationsProvider.setSelectedIndex(-1);
            threadBotProvider.setSelectedIndex(-1);
          }
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
          return agentsDisplay.map((agent) {
            return SizedBox(
              width: 190,
              child: Row(
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      agent.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
