import 'package:flutter/material.dart';

class AdvancedFeatures extends StatelessWidget {
  const AdvancedFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                                  color: Colors.green[700]
                              )
                          ),
                          TextSpan(
                            text: "unlimited*",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700]
                            ),
                          ),
                          TextSpan(
                            text: " queries.",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.green[700]
                            ),
                          ),
                        ]
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
