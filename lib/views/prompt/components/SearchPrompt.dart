import 'package:flutter/material.dart';

class SearchPrompt extends StatelessWidget {
  SearchPrompt({super.key, required this.controller, required this.onSubmitted , required this.isFavoriteChecked, required this.onTap, required this.isPublic});
  TextEditingController controller;
  bool isFavoriteChecked;
  VoidCallback onTap;
  Function(String) onSubmitted;
  bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey.shade50,
              hoverColor: Colors.transparent,
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.blueGrey),
              prefixIcon: const Icon(Icons.search, color: Colors.blueGrey,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Đặt độ bo góc
                borderSide: BorderSide.none, // Không có viền khi không focus
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 0.7)
              ),
            ),
          ),
        ),
        isPublic ?
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),

              ),
              child: Icon(
                isFavoriteChecked ? Icons.star : Icons.star_border,
                color: isFavoriteChecked ? Colors.yellow : Colors.grey,
                size: 30,
              ),
            ),
          ),
        ) : SizedBox.shrink()
      ],
    );
  }
}
