import 'package:flutter/material.dart';

class BotCard extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final VoidCallback? onFavorite; // Callback cho nút yêu thích
  final VoidCallback? onDelete; // Callback cho nút xóa

  const BotCard({
    required this.name,
    required this.description,
    required this.date,
    this.onFavorite, // Đảm bảo callback là tùy chọn (nullable)
    this.onDelete, // Đảm bảo callback là tùy chọn (nullable)
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.android, size: 40, color: Colors.blue),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: onFavorite != null
                          ? () => onFavorite!()
                          : null, // Kiểm tra null
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: onDelete != null
                          ? () => onDelete!()
                          : null, // Kiểm tra null
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            if (description.isNotEmpty)
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            Spacer(),
            Text(
              date,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
