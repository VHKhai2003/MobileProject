import 'package:code/models/UnitType.dart';
import 'package:flutter/material.dart';

class SelectUnitTypeDialog extends StatefulWidget {
  const SelectUnitTypeDialog({super.key});

  @override
  State<SelectUnitTypeDialog> createState() => _SelectUnitTypeDialogState();
}

class _SelectUnitTypeDialogState extends State<SelectUnitTypeDialog> {

  final List<UnitType> listUnitTypes = [
    UnitType(0, "Local files", "Upload pdf, docx,...", "assets/icons/local-files.png"),
    UnitType(1, "Website", "Connect Website to get data", "assets/icons/websites.png"),
    UnitType(2, "Google drive", "Connect Google drive to get data", "assets/icons/google-drive.png"),
    UnitType(3, "Slack", "Connect Slack to get data", "assets/icons/slack.png"),
    UnitType(4, "Confluence", "Connect Confluence to get data", "assets/icons/confluence.png"),
  ];

  int selectedUnitType = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Add unit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.close)),
        ],
      ),
      content: SizedBox(
        height: 400,
        width: 400,
        child: ListView.builder(
          itemCount: listUnitTypes.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: index == selectedUnitType ? Colors.blue.shade50 : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: index == selectedUnitType ? Colors.blue.shade400 : Colors.grey.shade400),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                onTap: () {
                  setState(() {
                    selectedUnitType = index;
                  });
                },
                title: Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: selectedUnitType,
                      onChanged: (value) {
                        setState(() {
                          selectedUnitType = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                listUnitTypes[index].image,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 6,),
                              Text(listUnitTypes[index].name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Text(listUnitTypes[index].description, style: TextStyle(fontSize: 14),),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
            onPressed: () {
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            child: const Text('Next',)
        ),
      ],
    );
  }
}