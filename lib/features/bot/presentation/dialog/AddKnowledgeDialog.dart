import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';

class AddKnowledgeDialog extends StatefulWidget {
  final String botId;
  final VoidCallback onSuccess;
  final VoidCallback onClose;
  final RLTBotAndKBProvider rltProvider;
  final List<String> listKnownledge;

  const AddKnowledgeDialog({
    Key? key,
    required this.botId,
    required this.onSuccess,
    required this.onClose,
    required this.rltProvider,
    required this.listKnownledge,
  }) : super(key: key);

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  void _loadInitialData(BuildContext context) {
    Future.microtask(() async {
      if (!context.mounted) return;
      try {
        final provider = context.read<KnowledgeProvider>();
        provider.setLoading(true);
        await provider.loadKnowledge('');
      } finally {
        if (context.mounted) {
          context.read<KnowledgeProvider>().setLoading(false);
        }
      }
    });
  }

  Future<void> _importKnowledge(Knowledge knowledge) async {
    try {
      final success = await widget.rltProvider.importKnowledgeToAssistant(
        widget.botId,
        knowledge.id,
      );

      if (success) {
        widget.onSuccess();
        if (mounted) {
          setState(() {});
        }
        Fluttertoast.showToast(
          msg: 'Knowledge imported successfully',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to import knowledge',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Select Knowledge',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {
              widget.onClose();
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(24, 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeList(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KnowledgeProvider(),
      child: Builder(
        builder: (builderContext) {
          _loadInitialData(builderContext);
          return Consumer<KnowledgeProvider>(
            builder: (_, knowledgeProvider, __) {
              if (knowledgeProvider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.grey.shade400,
                  ),
                );
              }
              if (knowledgeProvider.knowledges.isEmpty) {
                return Center(
                  child: Text(
                    'No knowledge available',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: knowledgeProvider.knowledges.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                itemBuilder: (_, index) {
                  final knowledge = knowledgeProvider.knowledges[index];
                  final bool isAdded = widget.rltProvider.knowledges
                          .any((k) => k.id == knowledge.id) ||
                      widget.listKnownledge.contains(knowledge.id);

                  return _buildKnowledgeItem(knowledge, isAdded);
                },
              );
            },
          );
        },
      ),
    );
  }

  // Widget _buildKnowledgeItem(Knowledge knowledge, bool isAdded) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 16,
  //     ),
  //     color: Colors.white,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Icon(
  //           Icons.description_outlined,
  //           size: 16,
  //           color: Colors.grey.shade500,
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 knowledge.knowledgeName,
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.black87,
  //                   height: 1.3,
  //                 ),
  //               ),
  //               if (knowledge.description?.isNotEmpty ?? false) ...[
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   knowledge.description ?? '',
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.blue.shade700,
  //                     height: 1.4,
  //                   ),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         TextButton(
  //           onPressed: isAdded ? null : () => _importKnowledge(knowledge),
  //           style: TextButton.styleFrom(
  //             backgroundColor:
  //                 isAdded ? Colors.grey.shade100 : Colors.blue.shade500,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 16,
  //               vertical: 6,
  //             ),
  //             minimumSize: const Size(0, 32),
  //             disabledBackgroundColor: Colors.grey.shade100,
  //           ),
  //           child: Text(
  //             'Import',
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: isAdded ? Colors.grey.shade500 : Colors.white,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildKnowledgeItem(Knowledge knowledge, bool isAdded) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/knowledge-base.png',
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  knowledge.knowledgeName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                if (knowledge.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 4),
                  Text(
                    knowledge.description ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: isAdded ? null : () => _importKnowledge(knowledge),
            style: TextButton.styleFrom(
              backgroundColor:
                  isAdded ? Colors.grey.shade100 : Colors.blue.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              minimumSize: const Size(0, 32),
              disabledBackgroundColor: Colors.grey.shade100,
            ),
            child: Text(
              'Import',
              style: TextStyle(
                fontSize: 12,
                color: isAdded ? Colors.grey.shade500 : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Flexible(
              child: _buildKnowledgeList(context),
            ),
          ],
        ),
      ),
    );
  }
}
