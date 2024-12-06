import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/dialog/DeleteKnowledgeDialog.dart';
import 'package:code/features/knowledge/presentation/units/UnitPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KnowledgeElement extends StatefulWidget {
  const KnowledgeElement({super.key, required this.knowledge, required this.deleteKnowledge, required this.editKnowledge});
  final Knowledge knowledge;
  final Function(String) deleteKnowledge;
  final Function(Knowledge) editKnowledge;

  @override
  State<KnowledgeElement> createState() => _KnowledgeElementState();
}

class _KnowledgeElementState extends State<KnowledgeElement> {
  late Knowledge knowledge;

  @override
  void initState() {
    super.initState();
    knowledge = widget.knowledge;
  }

  void _showDeleteKnowledgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteKnowledgeDialog(knowledge: knowledge, deleteKnowledge: widget.deleteKnowledge);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.grey, // Màu viền
            width: 0.3, // Độ dày của viền
          ),
        ),
        elevation: 5, // Độ cao của đổ bóng
        // shadowColor: Colors.blue, // Màu của bóng
        child: Stack(
            children: [
              Positioned.fill(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      // foregroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => UnitPage(knowledge: knowledge, editKnowledge: widget.editKnowledge),
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
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Image.asset(
                                    'assets/icons/knowledge-base.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    knowledge.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/unit.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                        "${knowledge.unit} ${knowledge.unit == 1 ? 'unit' : 'units'}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/memory.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                        "${knowledge.byte} ${knowledge.byte == 1 ? 'byte' : 'bytes'}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.time, color: Colors.grey, size: 20),
                                    SizedBox(width: 5),
                                    Text(
                                      knowledge.date,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    )
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.scale(
                      scale: 0.6, // Giảm kích thước của Switch
                      child: Switch(
                        value: knowledge.isEnable,
                        onChanged: (bool value) {
                          setState(() {
                            knowledge.isEnable = value;
                          });
                        },
                        activeColor: Colors.blueAccent,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outlined),
                      onPressed: () {
                        _showDeleteKnowledgeDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ]
        )
    );
  }
}
