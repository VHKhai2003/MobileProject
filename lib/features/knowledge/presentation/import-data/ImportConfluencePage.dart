import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:code/features/knowledge/providers/ImportDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ImportConfluencePage extends StatefulWidget {
  ImportConfluencePage({super.key});

  @override
  State<ImportConfluencePage> createState() => _ImportConfluencePageState();
}

class _ImportConfluencePageState extends State<ImportConfluencePage> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

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
              Image.asset('assets/icons/confluence.png', width: 32, height: 32,),
              SizedBox(width: 6,),
              Text('Confluence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ],
          ),
        ),
        Divider(height: 1,),
        SizedBox(height: 20,),
        CustomLabelAndTextField(controller: nameController, label: 'Name'),
        SizedBox(height: 30,),
        CustomLabelAndTextField(controller: urlController, label: 'Wiki Page URL'),
        SizedBox(height: 30,),
        CustomLabelAndTextField(controller: usernameController, label: 'Confluence Username'),
        SizedBox(height: 30,),
        CustomLabelAndTextField(controller: tokenController, label: 'Confluence Access Token'),
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
                String username = usernameController.text;
                String token = tokenController.text;
                if(name.trim().isEmpty) {
                  Fluttertoast.showToast(msg: 'Name must not be empty');
                  return;
                }
                if(url.trim().isEmpty) {
                  Fluttertoast.showToast(msg: 'url must not be empty');
                  return;
                }
                if(username.trim().isEmpty) {
                  Fluttertoast.showToast(msg: 'username must be not empty');
                  return;
                }
                if(token.trim().isEmpty) {
                  Fluttertoast.showToast(msg: 'Token must be not empty');
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                // await Future.delayed(Duration(seconds: 2));
                bool status = await importDataProvider.importConfluence(name, url, username, token);
                if(status) {
                  Navigator.of(context).pop(status);
                }
                else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(msg: 'Failed to import data from confluence');
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
