import 'package:code/features/knowledge/models/Unit.dart';
import 'package:code/features/knowledge/models/UnitTypeName.dart';
import 'package:code/features/knowledge/models/UnitTypeIcon.dart';
import 'package:code/features/knowledge/presentation/units/dialog/DeleteUnitDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnitElement extends StatefulWidget {
  const UnitElement({super.key, required this.unit});
  final Unit unit;

  @override
  State<UnitElement> createState() => _UnitElementState();
}

class _UnitElementState extends State<UnitElement> {
  late Unit unit;

  Map<String, String> types = {
    "file": UnitTypeIcon.local,
    UnitTypeName.slack: UnitTypeIcon.slack,
    UnitTypeName.drive: UnitTypeIcon.drive,
    "web": UnitTypeIcon.website,
    UnitTypeName.confluence: UnitTypeIcon.confluence
  };

  @override
  void initState() {
    super.initState();
    unit = widget.unit;
  }

  void _showDeleteUnitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteUnitDialog(unit: unit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.grey, // Màu viền
            width: 0.3, // Độ dày của viền
          ),
        ),
        elevation: 5, // Độ cao của đổ bóng
        // shadowColor: Colors.blue, // Màu của bóng
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
              children: [
                Positioned.fill(
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
                                  types[unit.type]!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  unit.name,
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
                              Text(
                                  "From ${unit.type}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey
                                  )
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
                                      "${(unit.size / 1024).toStringAsFixed(2)} KB",
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
                                      unit.createdAt.toIso8601String().substring(0, 10),
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
                          value: unit.status,
                          onChanged: (bool value) {
                            setState(() {
                              unit.status = value;
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
                          _showDeleteUnitDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}
