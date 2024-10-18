import 'package:flutter/material.dart';

class ActionWithName extends StatelessWidget {
  const ActionWithName({super.key, required this.actionName, required this.actionIcon, required this.actionDescription, required this.selectedAction});
  final String actionName;
  final IconData actionIcon;
  final String actionDescription;
  final Widget selectedAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            // backgroundColor: const Color(0xFFEBEFFF),
            // foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => selectedAction,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(actionIcon, size: 50, color: Colors.blueGrey,),
              Text(
                actionName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              Text(
                actionDescription,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey
                ),
              )
            ],
          )
      )
    );
  }
}
