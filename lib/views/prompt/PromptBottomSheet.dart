import 'package:code/views/prompt/dialog/AddDialog.dart';
import 'package:flutter/material.dart';
import 'package:code/views/prompt/ListPrompts.dart';

class Promptbottomsheet extends StatefulWidget {

  final BuildContext? context;

  const Promptbottomsheet({super.key, this.context});

  @override
  State<Promptbottomsheet> createState() => _PromptbottomsheetState();
}

class _PromptbottomsheetState extends State<Promptbottomsheet> {
  final List<bool> _selections = [true, false];
  bool _isChecked = false;
  bool _isShowAllCategories = false;

  final List<String> _categories = [
    "All", "Marketing", "Business", "SEO", "Writing", "Coding",
    "Career", "Chatbot", "Education", "Fun", "Productivity", "Other"
  ];

  String _selectedCategory = "All"; // Giá trị mặc định

  @override
  Widget build(BuildContext context) {
    List<String> categoriesList;
    if(_isShowAllCategories) {
      categoriesList = _categories;
    }
    else {
      categoriesList = _categories.sublist(0, 4);
    }

    return Container(
      height: 550,
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Prompt library", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        showDialog(context: context, builder: (context) => AddDialog());
                      }, icon: Icon(Icons.add_box_rounded, color: Colors.blue.shade700,)),
                      IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.close))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              ToggleButtons(
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    _selections[index] = true;
                    _selections[1 - index] = false;
                  });
                },
                borderRadius: BorderRadius.circular(30),
                selectedColor: Colors.white,
                constraints: const BoxConstraints(minWidth: 110, minHeight: 30),
                renderBorder: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                color: Colors.black,
                children: [
                  Container(
                    color: Colors.blueGrey.shade50,
                    child: Container(
                      width: 110,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selections.first ? Colors.blue.shade700 : Colors.transparent
                      ),
                      child: const Center(child: Text("My prompts")),
                    ),
                  ),
                  Container(
                    color: Colors.blueGrey.shade50,
                    child: Container(
                      width: 120,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selections.last ? Colors.blue.shade700 : Colors.transparent
                      ),
                      child: const Center(child: Text("Public prompts"),),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.search, color: Colors.blueGrey,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16), // Đặt độ bo góc
                            borderSide: BorderSide.none, // Không có viền khi không focus
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue.shade700, width: 0.7)
                          ),
                        ),
                      ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isChecked = !_isChecked;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),

                        ),
                        child: Icon(
                          _isChecked ? Icons.star : Icons.star_border,
                          color: _isChecked ? Colors.yellow : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8.0, // Khoảng cách giữa các phần tử
                      runSpacing: 8.0, // Khoảng cách giữa các dòng
                      children: categoriesList.map((category) {
                        return ChoiceChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: Colors.blue.shade700, // Màu khi được chọn
                          backgroundColor: Colors.blueGrey.shade50, // Màu nền mặc định
                          labelStyle: TextStyle(
                            color: _selectedCategory == category ? Colors.white : Colors.black, // Màu chữ
                          ),
                          shape: const StadiumBorder(
                            side: BorderSide.none,
                          ),
                          side: BorderSide.none,
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(onPressed: () {
                    setState(() {
                      _isShowAllCategories = !_isShowAllCategories;
                    });
                  }, icon: const Icon(Icons.arrow_drop_down_outlined))
                ],
              ),
              ListPrompts(),
            ],
          ),
    );
  }
}
