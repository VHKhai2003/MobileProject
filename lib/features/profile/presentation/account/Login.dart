import 'package:code/features/auth/presentation/LoginPage.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.account_box_rounded, color: Colors.blue),
        title: const Text('Sign in / Sign up', style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(state: "Login"),
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
      ),
    );
  }
}
