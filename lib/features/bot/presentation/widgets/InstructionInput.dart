import 'package:flutter/material.dart';

class InstructionInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onInstructionChange;
  final bool isUpdating;
  final bool showSuccess;

  const InstructionInput({
    Key? key,
    required this.controller,
    required this.onInstructionChange,
    required this.isUpdating,
    required this.showSuccess,
  }) : super(key: key);

  Widget _buildStatusIcon() {
    if (isUpdating) {
      return Container(
        width: 16,
        height: 16,
        padding: const EdgeInsets.all(2),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blue.shade700,
        ),
      );
    } else if (showSuccess) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.check_circle,
          size: 14,
          color: Colors.green.shade600,
        ),
      );
    }
    return const SizedBox(width: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 8, 32, 8),
              hintText: "Instructions...",
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 13,
              height: 1.3,
            ),
            maxLines: 1,
            onChanged: onInstructionChange,
          ),
        ),
        Positioned(
          right: 8,
          child: _buildStatusIcon(),
        ),
      ],
    );
  }
}
