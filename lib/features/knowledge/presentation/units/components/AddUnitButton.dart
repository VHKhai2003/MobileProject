import 'package:code/features/knowledge/presentation/units/dialog/SelectUnitTypeDialog.dart';
import 'package:code/features/knowledge/providers/UnitProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUnitButton extends StatelessWidget {
  const AddUnitButton({super.key});

  @override
  Widget build(BuildContext context) {
    UnitProvider provider = Provider.of<UnitProvider>(context, listen: false);

    return SizedBox(
      height: 44,
      child: FilledButton.icon(
        onPressed: () async {
          bool? status = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SelectUnitTypeDialog(knowledge: provider.knowledge,);
            },
          );

          if(status != null && status!) {
            provider.clearUnits();
            provider.setLoading(true);
            await provider.loadUnits();
            provider.setLoading(false);
          }
        },
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
        ),
        icon: const Icon(
          Icons.add,
          size: 20,
        ),
        label: const Text(
          'Add unit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );


    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     Container(
    //       margin: const EdgeInsets.symmetric(vertical: 10),
    //       decoration: BoxDecoration(
    //         color: Colors.blue.shade700,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: ElevatedButton(
    //         onPressed: () async {
    //          bool? status = await showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return SelectUnitTypeDialog(knowledge: provider.knowledge,);
    //             },
    //           );
    //
    //          if(status != null && status!) {
    //            provider.clearUnits();
    //            provider.setLoading(true);
    //            await provider.loadUnits();
    //            provider.setLoading(false);
    //          }
    //         },
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: Colors.transparent,
    //           shadowColor: Colors.transparent,
    //           foregroundColor: Colors.white,
    //         ),
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Icon(Icons.add_circle_outline, size: 20),
    //             SizedBox(width: 10),
    //             const Text(
    //               'Add unit',
    //               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
