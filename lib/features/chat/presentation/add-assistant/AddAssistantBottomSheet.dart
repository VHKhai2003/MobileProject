import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/chat/presentation/add-assistant/BotItem.dart';
import 'package:code/features/chat/presentation/add-assistant/SearchBot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAssistantBottomSheet extends StatefulWidget {

  const AddAssistantBottomSheet({super.key});

  @override
  State<AddAssistantBottomSheet> createState() => _AddAssistantBottomSheetState();
}

class _AddAssistantBottomSheetState extends State<AddAssistantBottomSheet> {
  String searchQuery = '';

  Future<void> _loadBots() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotProvider>().loadBots('');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBots();
  }

  @override
  Widget build(BuildContext context) {
    final botProvider = Provider.of<BotProvider>(context);
    List<Bot> filteredBots = searchQuery.isEmpty
        ? botProvider.bots
        : botProvider.bots
        .where((bot) =>
    bot.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        (bot.description?.toLowerCase() ?? '')
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // space for virtual keyboard
      ),
      child: Container(
        height: 530,
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add Assistant", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 10,),
            const SizedBox(height: 10,),
            SearchBot(),
            const SizedBox(height: 10,),
            botProvider.isLoading ?
            Expanded(child: Center(child: CircularProgressIndicator())) :
            Expanded(
              child: ListView.builder(
                itemCount: filteredBots.length,
                itemBuilder: (context, index) {
                  final bot = filteredBots[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: BotItem(
                      name: bot.name,
                      createdAt: bot.createdAt,
                      updatedAt: bot.updatedAt,
                      onTap: () {
                        Navigator.of(context).pop(bot);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
