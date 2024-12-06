import 'package:code/features/knowledge/presentation/import-data/layout/ImportDataPageLayout.dart';
import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:flutter/material.dart';

class ImportWebSitePage extends StatelessWidget {
  ImportWebSitePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

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
                  onPressed: () {
                    print(urlController.text);
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
