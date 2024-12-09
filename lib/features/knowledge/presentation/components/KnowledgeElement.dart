import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/dialog/DeleteKnowledgeDialog.dart';
import 'package:code/features/knowledge/presentation/units/UnitPage.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KnowledgeElement extends StatefulWidget {
  const KnowledgeElement({super.key, required this.knowledge});
  final Knowledge knowledge;

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

  void _showDeleteKnowledgeDialog(BuildContext context) async {
    KnowledgeProvider knowledgeProvider = Provider.of<KnowledgeProvider>(context, listen: false);

    bool? status = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteKnowledgeDialog(knowledge: knowledge, knowledgeProvider: knowledgeProvider);
      },
    );
    if(status != null) {
      Fluttertoast.showToast(msg: status! ? "Delete successfully" : "Failed to delete");
      if(status!) {
        knowledgeProvider.setLoading(true);
        knowledgeProvider.clearListKnowledge();
        await knowledgeProvider.loadKnowledge('');
        knowledgeProvider.setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    KnowledgeProvider provider = Provider.of<KnowledgeProvider>(context, listen: false);
    return Container(
      height: 150,
      child: Card(
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
                      onPressed: () async {
                        // go to Units page
                        await Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => UnitPage(knowledge: knowledge),
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
                        provider.setLoading(true);
                        provider.clearListKnowledge();
                        await provider.loadKnowledge('');
                        provider.setLoading(false);
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          knowledge.knowledgeName,
                                          style: TextStyle( color: Colors.black, fontSize: 20),
                                        ),
                                        Expanded(
                                          child: Text(
                                              knowledge.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.blue.shade900, fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
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
                                        "${knowledge.numUnits} ${knowledge.numUnits == 1 ? 'unit' : 'units'}",
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
                                        "${(knowledge.totalSize / 1024).toStringAsFixed(2)} KB",
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
                                      knowledge.updatedAt.toIso8601String().substring(0, 10),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          )

                        ],
                      )
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child:IconButton(
                    icon: Icon(Icons.delete_outlined),
                    onPressed: () {
                      _showDeleteKnowledgeDialog(context);
                    },
                  ),
                ),
              ]
          )
      ),
    );
  }
}
