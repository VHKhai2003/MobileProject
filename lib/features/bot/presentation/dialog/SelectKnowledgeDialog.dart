import 'package:flutter/material.dart';

class SelectKnowledgeDialog extends StatelessWidget {
  final List<Map<String, dynamic>> knowledges;

  const SelectKnowledgeDialog({super.key, required this.knowledges});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Select Knowledge',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: knowledges.length,
              itemBuilder: (context, index) {
                final knowledge = knowledges[index];
                return ListTile(
                  leading: Image.asset(
                    "assets/icons/knowledge-base.png",
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: 40, color: Colors.red);
                    },
                  ),
                  title: Text(knowledge['name']),
                  subtitle: Text('${knowledge['size']} MB'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      print('Added: ${knowledge['name']}');
                      Navigator.pop(context, knowledge);
                    },
                    child: const Text('Add'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
