import 'package:code/features/prompt/models/PromptCategory.dart';
import 'package:code/features/prompt/presentation/components/ListPrivatePrompt.dart';
import 'package:code/features/prompt/presentation/components/ListPublicPrompt.dart';
import 'package:code/features/prompt/presentation/components/NavigationTab.dart';
import 'package:code/features/prompt/presentation/components/SearchPrompt.dart';
import 'package:code/features/prompt/presentation/dialog/AddDialog.dart';
import 'package:flutter/material.dart';

class PromptBottomSheet extends StatefulWidget {

  const PromptBottomSheet({super.key});

  @override
  State<PromptBottomSheet> createState() => _PromptBottomSheetState();
}

class _PromptBottomSheetState extends State<PromptBottomSheet> {
  final List<bool> _selections = [true, false];
  void _handleUpdateSelections(int index) {
    setState(() {
      _selections[index] = true;
      _selections[1 - index] = false;
      keyword = '';
    });

    // some bug here
    // fix later... :>
    searchController.clear();
  }

  bool _isFavoriteChecked = false;
  void _toggleIsFavoriteCheck() {
    setState(() {
      _isFavoriteChecked = !_isFavoriteChecked;
    });
  }
  TextEditingController searchController = TextEditingController();
  String keyword = '';
  void _handleSearch(String value) {
    setState(() {
      keyword = value;
    });
    print('search $keyword');
  }


  bool _isShowAllCategories = false;
  String _selectedCategory = "all"; // default value

  DateTime current = DateTime.now();
  void updateCurrent(bool? status) {
    if(status != null && status) {
      setState(() {
        current = DateTime.now();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // space for virtual keyboard
      ),
      child: Container(
        height: 530,
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
                        IconButton(
                            onPressed: () async{
                              bool? createStatus = await showDialog(context: context, builder: (context) => AddDialog());
                              updateCurrent(createStatus);
                            },
                            icon: Icon(Icons.add_box_rounded, color: Colors.blue.shade700,)
                        ),
                        IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                NavigationTab(selections: _selections, onPressed: _handleUpdateSelections),
                const SizedBox(height: 10,),
                SearchPrompt(controller: searchController, onSubmitted: _handleSearch ,isFavoriteChecked: _isFavoriteChecked, onTap: _toggleIsFavoriteCheck, isPublic: _selections.last,),
                const SizedBox(height: 10,),
                _selections.last ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8.0, // Khoảng cách giữa các phần tử
                        runSpacing: 8.0, // Khoảng cách giữa các dòng
                        children: PromptCategory.categories.map((category) {
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
                    ],
                  ),
                ) : const SizedBox.shrink(),
                _selections.first ? ListPrivatePrompt(keyword: keyword, current: current,) : ListPublicPrompt(keyword: keyword, category: _selectedCategory, isFavorite: _isFavoriteChecked, current: current,)
              ],
            ),
      ),
    );
  }
}
