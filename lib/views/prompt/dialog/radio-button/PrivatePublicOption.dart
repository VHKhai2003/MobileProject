import 'package:flutter/material.dart';

class PrivatePublicOption extends StatelessWidget {

  final bool isPrivate;
  final Function(bool?) onChanged;

  const PrivatePublicOption({super.key, required this.isPrivate, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool>(
                value: true,
                groupValue: isPrivate,
                onChanged: onChanged,
              ),
              const Text('Private', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<bool>(
                value: false,
                groupValue: isPrivate,
                onChanged: onChanged,
              ),
              const Text('Public', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }
}
