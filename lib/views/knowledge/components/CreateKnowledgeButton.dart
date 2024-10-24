// import 'package:flutter/material.dart';

// class CreateKnowledgeButton extends StatelessWidget {
//   const CreateKnowledgeButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//               color: Colors.blueAccent,
//               borderRadius: BorderRadius.circular(10),
//           ),
//           child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 foregroundColor: Colors.white,
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.add_circle_outline, size: 20),
//                   SizedBox(width: 10),
//                   const Text(
//                     'Create knowledge',
//                     style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:code/views/knowledge/dialog/CreateKnowledge.dart';

class CreateKnowledgeButton extends StatelessWidget {
  const CreateKnowledgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Gọi hàm để hiển thị hộp thoại
              showCreateKnowledgeDialog(
                context,
                [], // Dữ liệu có thể được truyền nếu cần
                (name) {
                  // Callback xử lý khi tên thay đổi
                },
                (description) {
                  // Callback xử lý khi mô tả thay đổi
                },
                (unit) {
                  // Callback xử lý khi đơn vị được chọn
                },
                '', // Đơn vị đã chọn
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline, size: 20),
                SizedBox(width: 10),
                const Text(
                  'Create knowledge',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
