import 'package:code/features/knowledge/presentation/input-data-widgets/CustomLabelAndTextField.dart';
import 'package:flutter/material.dart';

class ImportConfluencePage extends StatelessWidget {
  ImportConfluencePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        CustomLabelAndTextField(controller: urlController, label: 'Confluence Access Token'),
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
    );
  }
}
