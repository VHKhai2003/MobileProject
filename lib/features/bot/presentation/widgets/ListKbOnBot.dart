import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';
import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';

class ListKbOnBot extends StatefulWidget {
  final List<String> listKnownledge;
  final String botId;

  const ListKbOnBot({
    Key? key,
    required this.listKnownledge,
    required this.botId,
  }) : super(key: key);

  @override
  State<ListKbOnBot> createState() => _ListKbOnBotState();
}

class _ListKbOnBotState extends State<ListKbOnBot> {
  bool _isRequesting = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RLTBotAndKBProvider>().getAssistantKnowledges(
            assistantId: widget.botId,
          );
    });
  }

  void _showAddKnowledgeDialog() {
    _debounceTimer?.cancel();
    if (_isRequesting) return;

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() => _isRequesting = true);
      final rltProvider = context.read<RLTBotAndKBProvider>();

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => Dialog(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Knowledge',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() => _isRequesting = false);
                        Navigator.pop(dialogContext);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 300,
                  child: ChangeNotifierProvider(
                    create: (_) => KnowledgeProvider(),
                    child: Builder(builder: (builderContext) {
                      Future.microtask(() async {
                        if (builderContext.mounted) {
                          try {
                            final provider =
                                builderContext.read<KnowledgeProvider>();
                            provider.setLoading(true);
                            await provider.loadKnowledge('');
                          } finally {
                            if (builderContext.mounted) {
                              builderContext
                                  .read<KnowledgeProvider>()
                                  .setLoading(false);
                              if (mounted) {
                                setState(() => _isRequesting = false);
                              }
                            }
                          }
                        }
                      });

                      return Consumer<KnowledgeProvider>(
                        builder: (_, knowledgeProvider, __) {
                          if (knowledgeProvider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (knowledgeProvider.knowledges.isEmpty) {
                            return const Center(
                              child: Text('No knowledge available'),
                            );
                          }

                          return ListView.builder(
                            itemCount: knowledgeProvider.knowledges.length,
                            itemBuilder: (_, index) {
                              final knowledge =
                                  knowledgeProvider.knowledges[index];
                              final bool isAdded =
                                  widget.listKnownledge.contains(knowledge.id);

                              return ListTile(
                                title: Text(
                                  knowledge.knowledgeName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isAdded ? Colors.grey : Colors.black,
                                  ),
                                ),
                                enabled: !isAdded,
                                onTap: isAdded
                                    ? null
                                    : () async {
                                        try {
                                          final success = await rltProvider
                                              .importKnowledgeToAssistant(
                                            widget.botId,
                                            knowledge.id,
                                          );
                                          if (success &&
                                              dialogContext.mounted) {
                                            await rltProvider
                                                .getAssistantKnowledges(
                                              assistantId: widget.botId,
                                            );
                                            if (dialogContext.mounted) {
                                              Navigator.pop(dialogContext);
                                            }
                                          }
                                        } finally {
                                          if (mounted) {
                                            setState(
                                                () => _isRequesting = false);
                                          }
                                        }
                                      },
                              );
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).whenComplete(() {
        if (mounted) {
          setState(() => _isRequesting = false);
        }
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Consumer<RLTBotAndKBProvider>(
          builder: (context, provider, child) {
            return PopupMenuButton<String>(
              offset: const Offset(0, 40),
              position: PopupMenuPosition.under,
              itemBuilder: (BuildContext context) => [
                if (provider.isLoading)
                  const PopupMenuItem(
                    enabled: false,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else
                  PopupMenuItem(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Knowledge Base',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: _showAddKnowledgeDialog,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (provider.knowledges.isEmpty)
                          const Text(
                            'No knowledge bases available',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        else
                          ...provider.knowledges.map(
                            (knowledge) {
                              return _buildKnowledgeItem(knowledge, provider);
                            },
                          ),
                      ],
                    ),
                  ),
              ],
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.library_books, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Knowledge (${widget.listKnownledge.length})',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildKnowledgeItem(
      Knowledge knowledge, RLTBotAndKBProvider provider) {
    final bool isAdded = widget.listKnownledge.contains(knowledge.id);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              knowledge.knowledgeName,
              style: TextStyle(
                fontSize: 12,
                color: isAdded ? Colors.blue : Colors.black87,
              ),
            ),
          ),
          IconButton(
            iconSize: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.add),
            onPressed: isAdded
                ? null
                : () {
                    provider.importKnowledgeToAssistant(
                      widget.botId,
                      knowledge.id,
                    );
                  },
          ),
        ],
      ),
    );
  }
}
