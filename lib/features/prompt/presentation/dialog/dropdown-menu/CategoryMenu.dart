import 'package:code/features/prompt/models/PromptCategory.dart';
import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key, required this.selectedCategory, required this.onChanged});
  final String selectedCategory;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10),
        ),
      child: DropdownButton<String>(
          menuMaxHeight: 300,
          items: PromptCategory.categories.map((category) =>
              DropdownMenuItem(
                value: category,
                child: Text(category, style: TextStyle(color: Colors.black87),),
              )
          ).toList(),
          onChanged: onChanged,
          value: selectedCategory,
          underline: const SizedBox(),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 20,
          borderRadius: BorderRadius.circular(16),
          style: const TextStyle(fontSize: 14),
        isExpanded: true,
      ),
    );
  }
}
