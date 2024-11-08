import 'package:code/views/upgrade/UpgradePage.dart';
import 'package:flutter/material.dart';
import 'package:code/views/profile/token-usage/TokenUsageIndicator.dart';


class TokenUsage extends StatelessWidget {
  const TokenUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEBEFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Token Usage", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/icons/fire.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => UpgradePage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
                            const end = Offset.zero; // Kết thúc tại vị trí gốc
                            const curve = Curves.easeInOut; // Hiệu ứng chuyển cảnh
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          }
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text('Upgrade', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(width: 4,),
                      Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 25)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Total", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            const TokenUsageWidget(totalTokens: 30, usedTokens: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10"),
                Text("30")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
