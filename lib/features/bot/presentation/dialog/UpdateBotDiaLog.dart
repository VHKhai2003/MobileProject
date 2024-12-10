import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';

class UpdateBotDialog extends StatefulWidget {
  const UpdateBotDialog(
      {super.key, required this.botProvider, required this.bot});
  final BotProvider botProvider;
  final Bot bot;

  @override
  State<UpdateBotDialog> createState() => _UpdateBotDialogState();
}

class _UpdateBotDialogState extends State<UpdateBotDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late int nameCharacterCount = 0;
  late int instructionsCharacterCount = 0;
  late int descriptionCharacterCount = 0;

  bool isLoading = false;
  bool isInitializing = true;

  @override
  void initState() {
    super.initState();
    _loadBotData();
  }

  Future<void> _loadBotData() async {
    try {
      // Fetch fresh data from server
      final freshBot = await widget.botProvider.getBot(widget.bot.id);

      if (mounted) {
        setState(() {
          nameController.text = freshBot.name;
          instructionsController.text = freshBot.instructions ?? '';
          descriptionController.text = freshBot.description ?? '';

          nameCharacterCount = freshBot.name.length;
          instructionsCharacterCount = freshBot.instructions?.length ?? 0;
          descriptionCharacterCount = freshBot.description?.length ?? 0;

          isInitializing = false;
        });
      }
    } catch (e) {
      print('Error loading fresh bot data: $e');
      if (mounted) {
        // Fallback to props data if fetch fails
        nameController.text = widget.bot.name;
        instructionsController.text = widget.bot.instructions ?? '';
        descriptionController.text = widget.bot.description ?? '';

        nameCharacterCount = widget.bot.name.length;
        instructionsCharacterCount = widget.bot.instructions?.length ?? 0;
        descriptionCharacterCount = widget.bot.description?.length ?? 0;

        setState(() => isInitializing = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    instructionsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Update Bot',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 500,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Bot Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: nameController,
                    cursorColor: Colors.blue.shade700,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      hintText: "Your bot is...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blue.shade700, width: 1),
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => nameCharacterCount = value.length),
                  ),
                  const SizedBox(height: 3),
                  Text("$nameCharacterCount/50",
                      style: const TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Instructions",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: instructionsController,
                    maxLines: 3,
                    cursorColor: Colors.blue.shade700,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      hintText: "Enter instructions for your bot...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blue.shade700, width: 1),
                      ),
                    ),
                    onChanged: (value) => setState(
                        () => instructionsCharacterCount = value.length),
                  ),
                  const SizedBox(height: 3),
                  Text("$instructionsCharacterCount/5000",
                      style: const TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Description",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    cursorColor: Colors.blue.shade700,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      hintText: "Enter description for your bot...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.blue.shade700, width: 1),
                      ),
                    ),
                    onChanged: (value) => setState(
                        () => descriptionCharacterCount = value.length),
                  ),
                  const SizedBox(height: 3),
                  Text("$descriptionCharacterCount/2000",
                      style: const TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              String name = nameController.text;
              if (name.trim().isEmpty) {
                Fluttertoast.showToast(msg: 'Bot name must not be empty');
                return;
              }
              setState(() => isLoading = true);
              bool status = await widget.botProvider.updateBot(
                widget.bot.id,
                name,
                instructionsController.text,
                descriptionController.text,
              );
              setState(() => isLoading = false);

              if (status) {
                widget.botProvider.clearListBot();
                widget.botProvider.loadBots('');
                Navigator.of(context).pop();
              }

              Fluttertoast.showToast(
                  msg: status
                      ? "Update bot successfully"
                      : "Failed to update bot");
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                const Text('Update'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
