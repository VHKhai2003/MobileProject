import 'package:code/views/auth/components/JarvisLogoAndLabel.dart';
import 'package:flutter/material.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color(0xFFEBEFFF),
          leading: IconButton(
              onPressed: () { Navigator.of(context).pop(); },
              icon: const Icon(Icons.close, size: 25, color: Colors.grey,)
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
          children: [
            JarvisLogoAndLabel(),
            Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                  'Pricing',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                  'Jarvis - Best AI Assistant Powered by GPT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(67, 106, 175, 1)
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                  'Upgrade plan now for a seamless, user-friendly experience. Unlock the full potential of our app and enjoy convenience at your fingertips.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  )
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bo góc của viền
                side: BorderSide(
                  color: Colors.blue, // Màu viền
                  width: 2, // Độ dày của viền
                ),
              ),
              elevation: 10, // Độ cao của đổ bóng (càng lớn thì bóng càng rõ)
              shadowColor: Colors.blue, // Màu của bóng
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/icons/infinity.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Text(
                                'Starter',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                              '1-month Free Trial',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(67, 106, 175, 1)
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Then',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '\$9.99/month',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color.fromRGBO(70, 139, 222, 1), Color.fromRGBO(116 ,185, 203, 1)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text(
                                          'Subscribe now',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Basic features',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'AI Chat Models',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Text(
                                'GPT-3.5 & GPT-4.0/Turbo & Gemini Pro & Gemini Ultra',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'AI Action Injection',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'Select Text for AI Action',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'More queries per month',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'Unlimited queries per month',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Advanced features',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'AI Reading Assistant',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'Real-time Web Access',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'AI Writing Assistant',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Color.fromRGBO(67, 106, 175, 1)),
                                ),
                                Expanded(
                                  child: Text(
                                    'AI Pro Search',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'Jira Copilot Assistant',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'Github Copilot Assistant',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Maximize productivity with ",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black
                                            )
                                        ),
                                        TextSpan(
                                          text: "unlimited*",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                          ),
                                        ),
                                        TextSpan(
                                          text: " queries.",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black
                                          ),
                                        ),
                                      ]
                                  )
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 0.1, color: Colors.grey, indent: 5, endIndent: 5),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Other benefits',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'No request limits during high-traffic',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    '2X faster response speed',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.check_circle_outline, color: Colors.green),
                                ),
                                Expanded(
                                  child: Text(
                                    'Priority email support',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}