import 'package:code/features/knowledge/presentation/import-data/layout/ImportDataPageLayout.dart';
import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:flutter/material.dart';

class ImportSlackPage extends StatelessWidget {
  ImportSlackPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController workspaceController = TextEditingController();
  final TextEditingController botTokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ImportDataPageLayout(
      child: SingleChildScrollView(
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
                  onPressed: () {
        
                  },
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
      ),
    );
  }
}
