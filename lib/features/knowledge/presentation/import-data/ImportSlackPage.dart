import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:code/features/knowledge/providers/ImportDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ImportSlackPage extends StatefulWidget {
  ImportSlackPage({super.key});

  @override
  State<ImportSlackPage> createState() => _ImportSlackPageState();
}

class _ImportSlackPageState extends State<ImportSlackPage> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController workspaceController = TextEditingController();
  final TextEditingController botTokenController = TextEditingController();

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
                Image.asset('assets/icons/slack.png', width: 32, height: 32,),
                SizedBox(width: 6,),
                Text('Slack', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
          ),
          Divider(height: 1,),
          SizedBox(height: 20,),
          CustomLabelAndTextField(controller: nameController, label: 'Name'),
          SizedBox(height: 30,),
          CustomLabelAndTextField(controller: workspaceController, label: 'Slack Workspace'),
          SizedBox(height: 30,),
          CustomLabelAndTextField(controller: botTokenController, label: 'Slack Bot Token'),
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
                  String workspace = workspaceController.text;
                  String token = botTokenController.text;
                  if(name.trim().isEmpty) {
                    Fluttertoast.showToast(msg: 'Name must not be empty');
                    return;
                  }
                  if(workspace.trim().isEmpty) {
                    Fluttertoast.showToast(msg: 'Workspace must not be empty');
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
                  bool status = await importDataProvider.importSlack(name, workspace, token);
                  if(status) {
                    Navigator.of(context).pop(status);
                  }
                  else {
                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(msg: 'Failed to import data from slack');
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
      ),
    );
  }
}
