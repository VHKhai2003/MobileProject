import 'package:flutter/material.dart';

class SelectKnowledgeDialog extends StatelessWidget {
  final List<Map<String, dynamic>> knowledges;

  const SelectKnowledgeDialog({super.key, required this.knowledges});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Knowledge',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              itemCount: knowledges.length,
              itemBuilder: (context, index) {
                final knowledge = knowledges[index];
                return ListTile(
                  leading: Icon(Icons.data_array_sharp),
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
          ],
        ),
      ),
    );
  }
}
