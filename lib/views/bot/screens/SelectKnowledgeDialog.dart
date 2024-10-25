import 'package:flutter/material.dart';

class SelectKnowledgeDialog extends StatelessWidget {
  final List<Map<String, dynamic>> knowledges;

  const SelectKnowledgeDialog({super.key, required this.knowledges});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // AppBar để hiển thị tiêu đề và nút đóng
          AppBar(
            automaticallyImplyLeading: false, // Không hiển thị nút quay lại
            title: Text(
              'Select Knowledge',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog khi nhấn nút X
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                IconThemeData(color: Colors.black), // Dùng màu đen cho icon
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: knowledges.length,
              itemBuilder: (context, index) {
                final knowledge = knowledges[index];
                return ListTile(
                  leading: Image.asset(
                    "assets/icons/knowledge-base.png", // Đảm bảo đường dẫn hợp lệ
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      // Hiển thị biểu tượng thay thế nếu ảnh không tải được
                      return Icon(Icons.error, size: 40, color: Colors.red);
                    },
                  ),
                  title: Text(knowledge['name']),
                  subtitle: Text('${knowledge['size']} MB'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      print('Added: ${knowledge['name']}');
                      Navigator.pop(context, knowledge);
                    },
                    child: const Text('Add'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
