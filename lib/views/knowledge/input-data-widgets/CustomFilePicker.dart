import 'package:flutter/material.dart';

class CustomFilePicker extends StatelessWidget {
  const CustomFilePicker({super.key, required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 280,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade700, width: 0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon( Icons.upload_file, size: 50, color: Colors.blue.shade700,),
            SizedBox(height: 10),
            Text(
              'Click to this area to upload',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16,),
            ),
            SizedBox(height: 10),
            Text(
              'Support for a single upload. Strictly prohibit from uploading company data or other banned files',
              textAlign: TextAlign.center,
              style: TextStyle( color: Colors.grey.shade600, fontSize: 14,),
            ),
          ],
        ),
      ),
    );
  }
}
