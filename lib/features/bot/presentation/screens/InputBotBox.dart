import 'package:flutter/material.dart';
import 'package:code/features/bot/presentation/screens/SelectKnowledgeDialog.dart';

class InputBotBox extends StatefulWidget {
  final VoidCallback changeConversation;
  final VoidCallback openNewChat;
  final List<String> listKnownledge;

  InputBotBox({
    Key? key,
    required this.changeConversation,
    required this.openNewChat,
    required this.listKnownledge,
  }) : super(key: key);

  @override
  _InputBotBoxState createState() => _InputBotBoxState();
}

class _InputBotBoxState extends State<InputBotBox> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage(String message, String? knowledge) {
    print("Tin nhắn gửi: $message, Kiến thức: $knowledge");
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ListKnownledge(listKnownledge: widget.listKnownledge),
                IconButton(
                  onPressed: () async {
                    List<Map<String, dynamic>> mockData = [
                      {"name": "New", "size": "0.77"},
                      {"name": "DRL", "size": "5.79"},
                      {"name": "Flutter", "size": "1.02"}
                    ];

                    final selectedKnowledge = await showDialog(
                      context: context,
                      builder: (context) =>
                          SelectKnowledgeDialog(knowledges: mockData),
                    );

                    if (selectedKnowledge != null) {
                      print('Bạn đã chọn: ${selectedKnowledge['name']}');
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.blueGrey),
                ),
              ],
            ),
            IconButton(
              onPressed: widget.openNewChat,
              icon:
                  Icon(Icons.add_comment_outlined, color: Colors.blue.shade700),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade800, width: 0.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Ask me anything, press '/' for prompts...",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 2, 2, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.blueGrey),
                    ),
                    IconButton(
                      onPressed: () {
                        String userMessage = _controller.text.trim();
                        if (userMessage.isNotEmpty &&
                            widget.listKnownledge.isNotEmpty) {
                          sendMessage(userMessage, widget.listKnownledge.first);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Input somethings')),
                          );
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListKnownledge extends StatelessWidget {
  final List<String> listKnownledge;

  const ListKnownledge({super.key, required this.listKnownledge});

  void _showKnowledgeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Available Knowledge",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: listKnownledge.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(listKnownledge[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          print('Xóa kiến thức: ${listKnownledge[index]}');
                        },
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showKnowledgeBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        constraints: BoxConstraints(maxHeight: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Text(
            "View Knowledge",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
