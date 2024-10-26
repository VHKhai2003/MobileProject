import 'package:flutter/material.dart';

class JarvisReply extends StatelessWidget {
  const JarvisReply({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey, // Màu viền
          width: 1, // Độ dày của viền
        ),
      ),
      elevation: 0, // Độ nổi của Card (bóng)
      // color: Colors.transparent, // Màu nền của Card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/jarvis-icon.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  'Jarvis reply',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(20, 80, 163, 1)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(height: 1),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("""Kính gửi [Họ và tên ứng viên],

Cảm ơn bạn đã quan tâm và gửi đơn ứng tuyển vào vị trí [Tên vị trí] tại [Tên công ty]. Sau khi xem xét kỹ lưỡng hồ sơ của bạn, chúng tôi rất tiếc phải thông báo rằng hiện tại chúng tôi đã tìm được ứng viên phù hợp hơn cho vị trí này.

Chúng tôi đánh giá cao những kinh nghiệm và kỹ năng của bạn, và hy vọng bạn sẽ tiếp tục thành công trong sự nghiệp. Nếu có cơ hội phù hợp trong tương lai, chúng tôi rất mong có thể xem xét hồ sơ của bạn một lần nữa.

Một lần nữa xin cảm ơn bạn đã dành thời gian ứng tuyển và chúc bạn nhiều thành công trong các cơ hội tiếp theo.

Trân trọng,
[Tên người gửi]
[Chức vụ]
[Tên công ty]
[Số điện thoại liên hệ]
[Địa chỉ email]""", style: TextStyle(fontSize: 15, letterSpacing: 0.5),),
            ),
            const SizedBox(height: 5),
            const Divider(height: 1),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.copy)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
