import 'package:flutter/material.dart';

class BotDashboard extends StatelessWidget {
  final Function(String)
      onBotTypeChanged; // Callback để xử lý khi thay đổi loại bot
  final Function(String) onSearch; // Callback để xử lý tìm kiếm
  final VoidCallback onCreateBot; // Callback để xử lý khi nhấn "Create bot"

  // Constructor của BotDashboard
  const BotDashboard({
    Key? key,
    required this.onBotTypeChanged,
    required this.onSearch,
    required this.onCreateBot,
  }) : super(key: key); // Chuyển tiếp key đến lớp cha

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Khung chứa cho loại bot và Dropdown
        Container(
          padding: const EdgeInsets.all(16.0), // Padding cho khung
          decoration: BoxDecoration(
            color: Colors.grey[200], // Màu nền khung
            borderRadius: BorderRadius.circular(8.0), // Bo góc
            border: Border.all(color: Colors.grey), // Đường viền
          ),
          child: Row(
            children: [
              Text(
                "Type: ",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: 'All', // Giá trị mặc định
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onBotTypeChanged(
                        newValue); // Gọi callback khi thay đổi loại bot
                  }
                },
                items: <String>['All', 'Bot1', 'Bot2', 'Bot3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Khung chứa cho ô tìm kiếm và nút "Create bot"
        Row(
          children: [
            // Khung chứa cho ô tìm kiếm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: 200, // Đặt chiều rộng cho ô tìm kiếm
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  onChanged: onSearch, // Gọi callback khi thay đổi tìm kiếm
                ),
              ),
            ),

            // Nút để tạo bot
            ElevatedButton.icon(
              onPressed: onCreateBot, // Gọi callback khi nhấn nút "Create bot"
              icon: Icon(Icons.add),
              label: Text("Create bot"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
