import 'package:flutter/material.dart';

class NavigationTab extends StatelessWidget {
  NavigationTab({super.key, required this.selections, required this.onPressed});
  List<bool> selections;
  void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: selections,
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(30),
      selectedColor: Colors.white,
      constraints: const BoxConstraints(minWidth: 110, minHeight: 30),
      renderBorder: false,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      color: Colors.black,
      children: [
        Container(
          color: Colors.blueGrey.shade50,
          child: Container(
            width: 110,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selections.first ? Colors.blue.shade700 : Colors.transparent
            ),
            child: const Center(child: Text("My prompts")),
          ),
        ),
        Container(
          color: Colors.blueGrey.shade50,
          child: Container(
            width: 120,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selections.last ? Colors.blue.shade700 : Colors.transparent
            ),
            child: const Center(child: Text("Public prompts"),),
          ),
        ),
      ],
    );
  }
}
