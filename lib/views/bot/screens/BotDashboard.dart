import 'package:flutter/material.dart';

class BotDashboard extends StatelessWidget {
  final Function(String)
      onBotTypeChanged; // Callback để xử lý khi thay đổi loại bot
  final Function(String) onSearch; // Callback để xử lý tìm kiếm
  final VoidCallback onCreateBot; // Callback để xử lý khi nhấn "Create bot"

  const BotDashboard({
    Key? key,
    required this.onBotTypeChanged,
    required this.onSearch,
    required this.onCreateBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn đều các phần tử
      children: [
        // Khung chứa cho loại bot và Dropdown
        Container(
          width: MediaQuery.of(context).size.width *
              0.3, // Chiếm 30% chiều rộng màn hình
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 8.0), // Giảm padding cho khung
          decoration: BoxDecoration(
            color: Colors.grey[200], // Màu nền khung
            borderRadius: BorderRadius.circular(8.0), // Bo góc
            border: Border.all(color: Colors.grey), // Đường viền
          ),
          child: Row(
            children: [
              Text(
                "Type: ",
                style: TextStyle(fontSize: 14), // Giảm kích thước font chữ
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
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Khung chứa cho ô tìm kiếm
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon:
                          Icon(Icons.search, size: 20), // Giảm kích thước icon
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0), // Giảm padding trong TextField
                    ),
                    onChanged: onSearch, // Gọi callback khi thay đổi tìm kiếm
                  ),
                ),
              ),

              // Nút để tạo bot
              ElevatedButton.icon(
                onPressed:
                    onCreateBot, // Gọi callback khi nhấn nút "Create bot"
                icon: Icon(Icons.add, size: 20), // Giảm kích thước icon
                label: Text(
                  "Create bot",
                  style:
                      TextStyle(fontSize: 14), // Giảm kích thước text của nút
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu nền
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12), // Giảm padding của nút
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
