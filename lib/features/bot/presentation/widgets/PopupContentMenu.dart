import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';

class KnowledgePopupContent extends StatefulWidget {
  final RLTBotAndKBProvider provider;
  final VoidCallback onAddKnowledge;
  final String botId;
  final Function(String, String) onDelete;

  const KnowledgePopupContent({
    Key? key,
    required this.provider,
    required this.onAddKnowledge,
    required this.botId,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<KnowledgePopupContent> createState() => _KnowledgePopupContentState();
}

class _KnowledgePopupContentState extends State<KnowledgePopupContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      constraints: const BoxConstraints(minHeight: 120),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Knowledge Base',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle,
                    size: 24, color: Colors.blueAccent),
                onPressed: widget.onAddKnowledge,
                tooltip: "Add Knowledge",
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          if (widget.provider.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.blueAccent),
              ),
            )
          else if (widget.provider.knowledges.isEmpty)
            const Center(
              child: Text(
                'No knowledge bases available',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            )
          else
            ...widget.provider.knowledges.map(
              (knowledge) => _buildKnowledgeItem(knowledge),
            ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeItem(Knowledge knowledge) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: SizedBox(
          height: 32,
          width: 32,
          child: Image.asset(
            'assets/icons/knowledge-base.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          knowledge.knowledgeName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          iconSize: 20, // Kích thước icon rõ ràng
          onPressed: () async {
            await widget.onDelete(widget.botId, knowledge.id);
            if (mounted) {
              setState(() {});
            }
          },
          tooltip: "Delete Knowledge",
        ),
      ),
    );
  }
}
