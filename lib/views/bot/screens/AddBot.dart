import 'package:flutter/material.dart';

class AddBot extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tiêu đề Assistant
            Text(
              'Create Assistant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),

            // Input cho Assistant Name
            TextField(
              controller: nameController,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Assistant name',
                labelStyle: TextStyle(color: Colors.red),
                counterText: "${nameController.text.length} / 50",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Input cho Assistant Description
            TextField(
              controller: descriptionController,
              maxLength: 2000,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Assistant description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Upload Profile Picture (Coming Soon)
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(child: Text('Coming soon')),
                ),
                SizedBox(width: 16),
                Text('Profile picture'),
              ],
            ),
            SizedBox(height: 16),

            // Nút OK và Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý logic tạo Assistant
                    String name = nameController.text;
                    String description = descriptionController.text;

                    // Thực hiện thêm Assistant logic ở đây (ví dụ: gọi API hoặc cập nhật state)

                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
