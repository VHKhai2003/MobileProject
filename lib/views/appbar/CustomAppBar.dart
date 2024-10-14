import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // kick thuoc cua appbar

   CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight), // thiet lap chieu cao mac dinh
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Row(
          children: [
            Text('Upgrade', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(width: 4,),
            Icon(Icons.rocket_launch, color: Colors.blue.shade700, size: 16,)
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
          child: Row(
            children: [
              const Text('50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
              Icon(Icons.local_fire_department_rounded, color: Colors.blue.shade700, size: 13,)
            ],
          ),
        )
      ],
    );
  }
}
