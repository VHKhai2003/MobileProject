import 'package:code/features/ai-action/providers/EmailProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class JarvisReply extends StatelessWidget {
  const JarvisReply({super.key});

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context);

    return emailProvider.isDisplayReply ?
    Card(
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
            Padding(
              padding: EdgeInsets.all(10),
              child: emailProvider.emailResponse == null ? SpinKitThreeBounce(
                color: Colors.grey,
                size: 15,
              ) : Text(emailProvider.emailResponse!.email, style: TextStyle(fontSize: 15, letterSpacing: 0.5),),
            ),
            if (emailProvider.emailResponse != null) ...[
              const SizedBox(height: 5),
              const Divider(height: 1),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: emailProvider.emailResponse!.email));
                          Fluttertoast.showToast(
                            msg: "Copied to clipboard!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        },
                        icon: const Icon(Icons.copy)
                    ),
                  )
                ],
              )
            ]
          ],
        ),
      ),
    ) :
    Container();
  }
}
