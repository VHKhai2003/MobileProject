import 'package:code/features/knowledge/presentation/import-data/layout/ImportDataPageLayout.dart';
import 'package:code/features/knowledge/presentation/input-data-widgets/CustomFilePicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImportLocalFilesPage extends StatefulWidget {
  const ImportLocalFilesPage({super.key});

  @override
  State<ImportLocalFilesPage> createState() => _ImportLocalFilesPageState();
}

class _ImportLocalFilesPageState extends State<ImportLocalFilesPage> {

  String? selectedFileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  void removeFile() {
    setState(() {
      selectedFileName = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ImportDataPageLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/local-files.png', width: 32, height: 32,),
                SizedBox(width: 6,),
                Text('Local file', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
          ),
          Divider(height: 1,),
          SizedBox(height: 8,),
          CustomFilePicker(onTap: pickFile,),
          SizedBox(height: 8,),
          selectedFileName != null
              ? Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.link_rounded, color: Colors.grey, size: 16,),
                    SizedBox(width: 4,),
                    Expanded(
                      child: Text(
                        selectedFileName!,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: removeFile,
                  icon: Icon(Icons.delete_outline, size: 16, color: Colors.grey,)
              )
            ],
          )
              : SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                ),
                child: Text('Connect'),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
