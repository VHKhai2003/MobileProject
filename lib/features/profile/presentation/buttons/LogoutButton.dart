import 'package:code/features/auth/presentation/LoginPage.dart';
import 'package:code/features/auth/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  static const _storage = FlutterSecureStorage();

  Future<void> clearAllTokens() async {
    await _storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        tileColor: const Color(0xFFEBEFFF),
        leading: const Icon(Icons.logout, color: Colors.redAccent),
        title: const Text('Log out', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
        trailing: const Icon(Icons.chevron_right, color: Colors.redAccent,),
        onTap: () async {
          Navigator.pushReplacement(
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
          await authProvider.logout();
          clearAllTokens();
        },
      ),
    );
  }
}
