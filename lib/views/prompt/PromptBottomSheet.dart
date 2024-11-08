import 'package:code/views/prompt/components/ListPrivatePrompt.dart';
import 'package:code/views/prompt/components/ListPublicPrompt.dart';
import 'package:code/views/prompt/components/NavigationTab.dart';
import 'package:code/views/prompt/components/SearchPrompt.dart';
import 'package:code/views/prompt/dialog/AddDialog.dart';
import 'package:flutter/material.dart';

class Promptbottomsheet extends StatefulWidget {

  final BuildContext? context;

  const Promptbottomsheet({super.key, this.context});

  @override
  State<Promptbottomsheet> createState() => _PromptbottomsheetState();
}

class _PromptbottomsheetState extends State<Promptbottomsheet> {
  final List<bool> _selections = [true, false];
  void _handleUpdateSelections(int index) {
    setState(() {
      _selections[index] = true;
      _selections[1 - index] = false;
    });
  }

  bool _isFavoriteChecked = false;
  void _toggleIsFavoriteCheck() {
    setState(() {
      _isFavoriteChecked = !_isFavoriteChecked;
    });
  }
  TextEditingController searchController = TextEditingController();

  bool _isShowAllCategories = false;

  final List<String> _categories = [
    "All", "Marketing", "Business", "SEO", "Writing", "Coding",
    "Career", "Chatbot", "Education", "Fun", "Productivity", "Other"
  ];
  String _selectedCategory = "All"; // default value


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
                      IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              NavigationTab(selections: _selections, onPressed: _handleUpdateSelections),
              const SizedBox(height: 10,),
              SearchPrompt(controller: searchController, isFavoriteChecked: _isFavoriteChecked, onTap: _toggleIsFavoriteCheck),
              const SizedBox(height: 10,),
              _selections.last ? Row(
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
              ) : const SizedBox.shrink(),
              _selections.first ? ListPrivatePrompt() : ListPublicPrompt()
            ],
          ),
    );
  }
}
