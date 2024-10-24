import 'package:code/views/knowledge/units/dialog/SelectUnitTypeDialog.dart';
import 'package:flutter/material.dart';

class AddUnitButton extends StatelessWidget {
  const AddUnitButton({super.key});

  void _showSelectUnitTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectUnitTypeDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
              onPressed: () {
                _showSelectUnitTypeDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline, size: 20),
                  SizedBox(width: 10),
                  const Text(
                    'Add unit',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }
}
