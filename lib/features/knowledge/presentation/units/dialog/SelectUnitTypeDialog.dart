import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/models/UnitType.dart';
import 'package:code/features/knowledge/models/UnitTypeIcon.dart';
import 'package:code/features/knowledge/models/UnitTypeName.dart';
import 'package:code/features/knowledge/presentation/import-data/ImportConfluencePage.dart';
import 'package:code/features/knowledge/presentation/import-data/ImportGoogleDriveFilePage.dart';
import 'package:code/features/knowledge/presentation/import-data/ImportLocalFilesPage.dart';
import 'package:code/features/knowledge/presentation/import-data/ImportSlackPage.dart';
import 'package:code/features/knowledge/presentation/import-data/ImportWebsitePage.dart';
import 'package:code/features/knowledge/presentation/import-data/layout/ImportDataPageLayout.dart';
import 'package:flutter/material.dart';

class SelectUnitTypeDialog extends StatefulWidget {
  const SelectUnitTypeDialog({super.key, required this.knowledge});

  final Knowledge knowledge;

  @override
  State<SelectUnitTypeDialog> createState() => _SelectUnitTypeDialogState();
}

class _SelectUnitTypeDialogState extends State<SelectUnitTypeDialog> {

  final List<UnitType> listUnitTypes = [
    UnitType(0, UnitTypeName.local, "Upload pdf, docx,...", UnitTypeIcon.local),
    UnitType(1, UnitTypeName.website, "Connect Website to get data", UnitTypeIcon.website),
    UnitType(2, UnitTypeName.drive, "Connect Google drive to get data", UnitTypeIcon.drive),
    UnitType(3, UnitTypeName.slack, "Connect Slack to get data", UnitTypeIcon.slack),
    UnitType(4, UnitTypeName.confluence, "Connect Confluence to get data", UnitTypeIcon.confluence),
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
            onPressed: () async {
              Widget page;
              if(selectedUnitType == 0) {
                page = ImportLocalFilesPage();
              }
              else if(selectedUnitType == 1) {
                page = ImportWebSitePage();
              }
              else if(selectedUnitType == 2) {
                page = ImportGoogleDriveFilePage();
              }
              else if(selectedUnitType == 3) {
                page = ImportSlackPage();
              }
              else {
                page = ImportConfluencePage();
              }
              bool? status = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImportDataPageLayout(child: page, knowledge: widget.knowledge))
              );

              Navigator.of(context).pop(status);
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
