import 'package:flutter/material.dart';

class CreateBotDialog extends StatefulWidget {
  const CreateBotDialog({super.key, required this.createNewBot});
  final Function(String name, String description) createNewBot;

  @override
  State<CreateBotDialog> createState() => _CreateBotDialogState();
}

class _CreateBotDialogState extends State<CreateBotDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late int nameCharacterCount = 0;
  late int descriptionCharacterCount = 0;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 400,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "* ",
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Bot Name",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: nameController,
                    cursorColor: Colors.indigoAccent,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.indigoAccent, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        nameCharacterCount = value.length;
                      });
                    },
                  ),
                  const SizedBox(height: 3),
                  Text("$nameCharacterCount/50",
                      style: const TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Bot Description",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    cursorColor: Colors.indigoAccent,
                    style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.indigoAccent, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        descriptionCharacterCount = value.length;
                      });
                    },
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String name = nameController.text;
              String description = descriptionController.text;
              widget.createNewBot(name, description);
              Navigator.of(context).pop(); // Đóng dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
