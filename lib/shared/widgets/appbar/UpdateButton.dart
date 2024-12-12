import 'package:code/core/constants/ApiConstants.dart';
import 'package:code/shared/providers/TokenUsageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> with WidgetsBindingObserver {

  Future<void> redirectTo(String url) async {
    final Uri uri = Uri.parse(url);
    // if (await canLaunch(url)) {
        await launchUrl(uri);
    // launch(url);
    // } else {
    //   print('Can not redirect to: $url');
    // }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("Application comes from background!");
      // call getUsage here to update status
      // final tokenUsageProvider = Provider.of<TokenUsageProvider>(context, listen: false);
      // tokenUsageProvider.getUsage1();
    } else if (state == AppLifecycleState.paused) {
      print("Application is paused");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        redirectTo(ApiConstants.upgradeUrl);
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //       pageBuilder: (context, animation, secondaryAnimation) => UpgradePage(),
        //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //         const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
        //         const end = Offset.zero; // Kết thúc tại vị trí gốc
        //         const curve = Curves.easeInOut; // Hiệu ứng chuyển cảnh
        //         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //         var offsetAnimation = animation.drive(tween);
        //         return SlideTransition(
        //           position: offsetAnimation,
        //           child: child,
        //         );
        //       }
        //   ),
        // );
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
    );
  }
}
