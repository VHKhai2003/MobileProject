import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:code/features/knowledge/providers/ImportDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ImportWebSitePage extends StatefulWidget {
  const ImportWebSitePage({super.key});

  @override
  State<ImportWebSitePage> createState() => _ImportWebSitePageState();
}

class _ImportWebSitePageState extends State<ImportWebSitePage> {

  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ImportDataProvider importDataProvider = Provider.of<ImportDataProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/websites.png', width: 32, height: 32,),
                SizedBox(width: 6,),
                Text('Website', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
          ),
          Divider(height: 1,),
          SizedBox(height: 20,),
          CustomLabelAndTextField(controller: nameController, label: 'Name'),
          SizedBox(height: 30,),
          CustomLabelAndTextField(controller: urlController, label: 'Web URL'),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  if(isLoading) {
                    return;
                  }
                  String name = nameController.text;
                  String url = urlController.text;
                  if(name.trim().isEmpty) {
                    Fluttertoast.showToast(msg: 'Name must not be empty');
                    return;
                  }
                  if(url.trim().isEmpty) {
                    Fluttertoast.showToast(msg: 'URL must not be empty');
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });
                  // await Future.delayed(Duration(seconds: 2));
                  bool status = await importDataProvider.importWebsite(name, url);
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
                    SizedBox(width: 4,),
                    Text('Connect'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
