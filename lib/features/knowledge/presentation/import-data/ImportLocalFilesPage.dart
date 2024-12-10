import 'package:code/features/knowledge/presentation/input-data-widgets/CustomFilePicker.dart';
import 'package:code/features/knowledge/providers/ImportDataProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ImportLocalFilesPage extends StatefulWidget {
  const ImportLocalFilesPage({super.key});

  @override
  State<ImportLocalFilesPage> createState() => _ImportLocalFilesPageState();
}

class _ImportLocalFilesPageState extends State<ImportLocalFilesPage> {

  bool isLoading = false;
  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.single;
      });
    }
  }

  void removeFile() {
    setState(() {
      selectedFile = null;
    });
  }


  @override
  Widget build(BuildContext context) {

    ImportDataProvider importDataProvider = Provider.of<ImportDataProvider>(context, listen: false);
    
    return Column(
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
        selectedFile != null
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
                      selectedFile!.name,
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
              onPressed: () async {
                if(isLoading) {
                  return;
                }
                if(selectedFile == null) {
                  Fluttertoast.showToast(msg: 'Please choose a localfile');
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                // await Future.delayed(Duration(seconds: 2));
                bool status = await importDataProvider.importFile(selectedFile!);
                // print('$selectedFilePath === $selectedFileName');
                if(status) {
                  Navigator.of(context).pop(status);
                }
                else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(msg: 'Failed to import data');
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading ? SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ) : SizedBox.shrink(),
                  SizedBox(width: 6,),
                  Text('Connect'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
