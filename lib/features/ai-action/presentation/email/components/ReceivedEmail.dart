import 'package:flutter/material.dart';

class ReceivedEmail extends StatelessWidget {
  const ReceivedEmail({super.key, required this.receivedEmailController});
  final TextEditingController receivedEmailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Received email", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
        //         controller: TextEditingController(text: """Kính gửi [Tên người nhận hoặc Bộ phận Tuyển dụng],
        //
        // Tôi tên là [Họ và tên], tôi xin phép được ứng tuyển vào vị trí [Tên vị trí] tại [Tên công ty]. Qua tìm hiểu, tôi nhận thấy đây là một cơ hội tốt để phát triển sự nghiệp và đồng thời đóng góp vào sự phát triển của công ty.
        //
        // Tôi đã tốt nghiệp chuyên ngành [Tên chuyên ngành] tại [Tên trường đại học] và có kinh nghiệm làm việc tại [Tên công ty cũ hoặc mô tả ngắn về kinh nghiệm làm việc nếu có]. Trong quá trình làm việc, tôi đã tích lũy được những kỹ năng cần thiết như [liệt kê các kỹ năng quan trọng liên quan đến vị trí ứng tuyển].
        //
        // Tôi tin rằng với những kiến thức và kinh nghiệm của mình, tôi có thể hoàn thành tốt các nhiệm vụ tại vị trí này và đóng góp tích cực vào sự thành công của công ty.
        //
        // Tôi đã đính kèm CV chi tiết để quý công ty có thể tham khảo thêm về quá trình học tập và làm việc của tôi. Rất mong sớm nhận được phản hồi từ quý công ty và có cơ hội trao đổi thêm về công việc trong buổi phỏng vấn.
        //
        // Xin chân thành cảm ơn và kính chúc quý công ty ngày càng phát triển.
        //
        // Trân trọng,
        // [Họ và tên]
        // [Số điện thoại liên hệ]
        // [Địa chỉ email]"""),
            controller: receivedEmailController,
            maxLines: 7,
            minLines: 5,
            cursorColor: Colors.indigoAccent,
            style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(242, 243, 250, 1),
              hintText: "Enter received email here...",
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
              ),
            ),
            scrollController: ScrollController(), // Để điều khiển việc cuộn
          ),
        ),
      ],
    );
  }
}
