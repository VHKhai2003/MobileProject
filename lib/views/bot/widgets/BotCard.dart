import 'package:flutter/material.dart';

class BotCard extends StatefulWidget {
  final String name;
  final String description;
  final String date;
  final bool
      isFavorite; // Thêm thuộc tính isFavorite để theo dõi trạng thái ban đầu
  final VoidCallback? onFavorite;
  final VoidCallback? onDelete;
  final VoidCallback? onTap; // Thêm onTap ở đây

  const BotCard({
    required this.name,
    required this.description,
    required this.date,
    this.isFavorite = false, // Mặc định không phải favorite
    this.onFavorite,
    this.onDelete,
    this.onTap,
  });

  @override
  _BotCardState createState() => _BotCardState();
}

class _BotCardState extends State<BotCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite; // Khởi tạo trạng thái từ widget cha
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; // Đổi trạng thái khi nhấn vào icon
    });
    if (widget.onFavorite != null) {
      widget.onFavorite!(); // Gọi callback nếu có
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Thay Card thành GestureDetector
      onTap: widget.onTap, // Gọi callback khi nhấn
      child: Card(
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
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isFavorite
                              ? Icons.star
                              : Icons
                                  .star_border, // Thay đổi icon dựa trên trạng thái
                          color: _isFavorite
                              ? Colors.blue
                              : null, // Đổi màu nếu đang là favorite
                        ),
                        onPressed:
                            _toggleFavorite, // Thay vì gọi trực tiếp callback, gọi hàm toggle
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: widget.onDelete != null
                            ? () => widget.onDelete!()
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (widget.description.isNotEmpty)
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              SizedBox(height: 8),
              Text(
                widget.date,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
