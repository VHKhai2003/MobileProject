import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code/features/bot/provider/RLTBotAndKBProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dialog/AddKnowledgeDialog.dart';
import 'PopupContentMenu.dart';

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
      _loadKnowledges();
    });
  }

  Future<void> _loadKnowledges() async {
    final provider = context.read<RLTBotAndKBProvider>();
    await provider.getAssistantKnowledges(assistantId: widget.botId);
  }

  Future<void> _deleteKnowledge(String botId, String knowledgeId) async {
    final provider = context.read<RLTBotAndKBProvider>();

    try {
      provider.removeKnowledge(knowledgeId);
      widget.listKnownledge.remove(knowledgeId);
      setState(() {});

      final success = await provider.deleteKnowledgeFromAssistant(
        botId,
        knowledgeId,
      );

      if (success) {
        await _loadKnowledges();
        Fluttertoast.showToast(
          msg: 'Knowledge removed successfully',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        await _loadKnowledges();
        Fluttertoast.showToast(
          msg: 'Failed to remove knowledge',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      await _loadKnowledges();
      Fluttertoast.showToast(
        msg: 'Error removing knowledge',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _showAddKnowledgeDialog(
      BuildContext context, RLTBotAndKBProvider provider) {
    _debounceTimer?.cancel();
    if (_isRequesting) return;

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() => _isRequesting = true);
      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AddKnowledgeDialog(
          botId: widget.botId,
          onSuccess: _loadKnowledges,
          onClose: () => setState(() => _isRequesting = false),
          rltProvider: provider,
          listKnownledge: widget.listKnownledge,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RLTBotAndKBProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<String>(
          offset: const Offset(0, 40),
          position: PopupMenuPosition.under,
          enabled: !provider.isLoading,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              enabled: true,
              child: KnowledgePopupContent(
                provider: provider,
                onAddKnowledge: () =>
                    _showAddKnowledgeDialog(context, provider),
                botId: widget.botId,
                onDelete: _deleteKnowledge,
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (provider.isLoading) ...[
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 8),
                ] else ...[
                  const Icon(Icons.library_books, size: 16),
                  const SizedBox(width: 4),
                ],
                Text(
                  'Knowledge (${provider.knowledges.length})',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
