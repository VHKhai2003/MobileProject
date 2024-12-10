import 'package:flutter/material.dart';

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
                        onPressed: () {},
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
