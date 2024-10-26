import 'package:flutter/material.dart';

class HistoryBottomSheet extends StatelessWidget {
  HistoryBottomSheet({super.key});

  final List<String> messages = [
    "Hello assistant", "write a simple console application in c++", "How to install android sdk"
  ];
  final List<int> times = [2, 5, 12];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              IconButton(onPressed: () {
                Navigator.of(context).pop("close");
              }, icon: const Icon(Icons.close))
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  color: index == selectedIndex ? Colors.blueGrey.shade50 : Colors.white,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop("open");
                    },
                    title: Row(
                      children: [
                        index == selectedIndex ? Container(
                          padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                          margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 23, 37, 84),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('current', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),),
                        ) : const SizedBox.shrink(),
                        Text(
                          messages[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '${times[index]} hours ago',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blueGrey,
                  thickness: 0.5,
                  height: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
