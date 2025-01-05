import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code/features/bot/provider/BotProvider.dart';

class CreateBotDialog extends StatefulWidget {
  const CreateBotDialog({super.key, required this.botProvider});
  final BotProvider botProvider;

  @override
  State<CreateBotDialog> createState() => _CreateBotDialogState();
}

class _CreateBotDialogState extends State<CreateBotDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode instructionsFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  late int nameCharacterCount = 0;
  late int instructionsCharacterCount = 0;
  late int descriptionCharacterCount = 0;

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    instructionsController.dispose();
    descriptionController.dispose();
    nameFocusNode.dispose();
    instructionsFocusNode.dispose();
    descriptionFocusNode.dispose();
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
              'Create New Bot',
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
                      text: "* ",
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
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
                    focusNode: nameFocusNode,
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
                    onSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(instructionsFocusNode),
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
                    focusNode: instructionsFocusNode,
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
                    onSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(descriptionFocusNode),
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
                    focusNode: descriptionFocusNode,
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
              bool status = await widget.botProvider.createBot(
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
                      ? "Create bot successfully"
                      : "Failed to create bot");
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
                const Text('Confirm'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
