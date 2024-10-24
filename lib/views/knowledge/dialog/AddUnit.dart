import 'package:flutter/material.dart';

void showSelectUnitDialog(
    BuildContext context,
    List<Map<String, dynamic>> data,
    String knowledgeName,
    String initialSelectedUnit,
    Function(String) onUnitSelected) {
  String selectedUnit = initialSelectedUnit; // Khởi tạo biến chọn đơn vị
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Unit'),
        content: Container(
          height: 300,
          width: 400,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        buildUnitOption(
                            'Local files',
                            'Upload pdf, docx, ...',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                        buildUnitOption(
                            'Website',
                            'Connect Website to get data',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                        buildUnitOption(
                            'Github repositories',
                            'Connect Github repositories to get data',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                        buildUnitOption(
                            'Gitlab repositories',
                            'Connect Gitlab repositories to get data',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                        buildUnitOption(
                            'Google Drive',
                            'Connect Google Drive to get data',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                        buildUnitOption(
                            'Slack',
                            'Connect Slack to get data',
                            'assets/icons/google-icon.png',
                            selectedUnit,
                            setState),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedUnit.isNotEmpty) {
                onUnitSelected(
                    selectedUnit); // Gọi hàm để cập nhật selectedUnit
                data.add({
                  "knowledge": knowledgeName,
                  "units": 1,
                  "size": "Unknown",
                  "editTime": DateTime.now().toString(),
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Next'),
          ),
        ],
      );
    },
  );
}

Widget buildUnitOption(String title, String description, String imagePath,
    String selectedUnit, StateSetter setState) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(description, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        Radio<String>(
          value: title,
          groupValue: selectedUnit,
          onChanged: (value) {
            setState(() {
              selectedUnit = value!;
              print('Selected Unit: $selectedUnit');
            });
          },
          activeColor: Colors.blue,
        ),
      ],
    ),
  );
}
