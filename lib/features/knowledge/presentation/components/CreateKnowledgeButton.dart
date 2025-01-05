import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/dialog/CreateKnowledgeDialog.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateKnowledgeButton extends StatelessWidget {
  const CreateKnowledgeButton({super.key});

  void _showCreateKnowledgeDialog(BuildContext context) async {
    KnowledgeProvider knowledgeProvider = Provider.of<KnowledgeProvider>(context, listen: false);
    bool? status = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateKnowledgeDialog(knowledgeProvider: knowledgeProvider,);
      },
    );
    if(status != null && status!) {
      knowledgeProvider.setLoading(true);
      knowledgeProvider.clearListKnowledge();
      await knowledgeProvider.loadKnowledge('');
      knowledgeProvider.setLoading(false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 44,
          child: FilledButton.icon(
            onPressed: () {
              _showCreateKnowledgeDialog(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
            ),
            icon: const Icon(
              Icons.add,
              size: 20,
            ),
            label: const Text(
              'Create Knowledge',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.symmetric(vertical: 10),
    //       decoration: BoxDecoration(
    //         color: Colors.blue.shade700,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: ElevatedButton(
    //           onPressed: () {
    //             _showCreateKnowledgeDialog(context);
    //           },
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Colors.transparent,
    //             shadowColor: Colors.transparent,
    //             foregroundColor: Colors.white,
    //           ),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Icon(Icons.add_circle_outline, size: 20),
    //               SizedBox(width: 10),
    //               const Text(
    //                 'Create knowledge',
    //                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //               ),
    //             ],
    //           )
    //       ),
    //     ),
    //   ],
    // );
  }
}
