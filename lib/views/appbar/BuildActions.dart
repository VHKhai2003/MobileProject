import 'package:code/views/upgrade/UpgradePage.dart';
import 'package:flutter/material.dart';

List<Widget> buildActions(BuildContext context) {
  return [
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
          Text(
            'Upgrade',
            style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          const SizedBox(width: 4),
          Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 20),
        ],
      ),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Row(
        children: const [
          Text(
            '50',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(width: 5),
          Image(
            image: AssetImage('assets/icons/fire.png'),
            width: 20,
            height: 20,
          ),
        ],
      ),
    ),
  ];
}
