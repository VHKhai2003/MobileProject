import 'package:flutter/material.dart';

class BotDashboard extends StatefulWidget {
  final Function(String) onBotTypeChanged;
  final Function(String) onSearch;
  final VoidCallback onCreateBot;

  BotDashboard({
    Key? key,
    required this.onBotTypeChanged,
    required this.onSearch,
    required this.onCreateBot,
  }) : super(key: key);

  @override
  State<BotDashboard> createState() => _BotDashboardState();
}

class _BotDashboardState extends State<BotDashboard> {
  final TextEditingController searchController = TextEditingController();
  String dropdownValue = 'All';
  List<String> list = <String>['All', 'Favorite'];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownMenu<String>(
              initialSelection: list.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries:
                  list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    widget.onSearch(value); // Gọi callback khi tìm kiếm
                  },
                  cursorColor: Colors.indigoAccent,
                  decoration: InputDecoration(
                    hintText: 'Find bot here ...',
                    prefixIcon: const Icon(Icons.search),
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.indigoAccent, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: widget.onCreateBot,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_circle_outline, size: 20),
                  const SizedBox(width: 10),
                  const Text(
                    'New bot',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
