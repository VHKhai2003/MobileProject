import 'package:flutter/material.dart';

class InstructionInput extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onInstructionChange;
  final bool isUpdating;
  final bool showSuccess;
  final VoidCallback onCancel;

  const InstructionInput({
    Key? key,
    required this.controller,
    required this.onInstructionChange,
    required this.isUpdating,
    required this.showSuccess,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<InstructionInput> createState() => _InstructionInputState();
}

class _InstructionInputState extends State<InstructionInput> {
  String _tempInstruction = '';
  final TextEditingController _dialogController = TextEditingController();
  bool _isLoading = false;

  void _showEditDialog() {
    _tempInstruction = widget.controller.text;
    _dialogController.text = _tempInstruction;
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      barrierDismissible: !_isLoading,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: Colors.blue.shade700,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Edit Instructions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Add specific instructions to guide the bot\'s responses',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: _dialogController,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText:
                          "E.g., Answer in a professional tone, Be concise...",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                    maxLines: 5,
                    minLines: 3,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              widget.onCancel();
                              Navigator.of(context).pop();
                            },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() => _isLoading = true);
                              widget.controller.text = _dialogController.text;
                              widget
                                  .onInstructionChange(_dialogController.text);
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                if (mounted) {
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Update Instructions',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _showEditDialog,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.edit,
              size: 16,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
