import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/models/Unit.dart';
import 'package:code/features/knowledge/presentation/units/components/AddUnitButton.dart';
import 'package:code/features/knowledge/presentation/units/components/UnitElement.dart';
import 'package:code/features/knowledge/providers/UnitProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUnits extends StatefulWidget {
  const ListUnits({super.key});

  @override
  State<ListUnits> createState() => _ListUnitsState();
}

class _ListUnitsState extends State<ListUnits> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> initData() async {
    UnitProvider provider = Provider.of<UnitProvider>(context, listen: false);
    provider.setLoading(true);
    try {
      await provider.loadUnits();
    } catch (e) {
    } finally {
      provider.setLoading(false);
    }
  }

  Future<void> fetchData() async {
    UnitProvider provider = Provider.of<UnitProvider>(context, listen: false);
    try {
      await provider.loadUnits();
    } catch (e) {
    } finally {
      provider.setLoading(false);
    }
  }


  @override
  Widget build(BuildContext context) {
    UnitProvider unitProvider = Provider.of<UnitProvider>(context);
    List<Unit> units = unitProvider.units;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AddUnitButton()
                ],
              ),
            ),
            if(unitProvider.isLoading)
              Expanded(
                  child: Center(child: CircularProgressIndicator(),)
              )
            else if (units.isEmpty) ...[
              SizedBox(height: 30),
              Image.asset(
                'assets/icons/empty-box.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text("No data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                "Add a unit to store your data.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    return UnitElement(unit: units[index]);
                  },
                  // padding: const EdgeInsets.all(10),
                ),
              ),
              unitProvider.hasNext
                  ? Center(
                    child: Container(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: TextButton(
                    onPressed: () async {
                      await unitProvider.loadUnits();
                    },
                      child: Text('More...', style: TextStyle(color: Colors.blue),)),
                    ),
                  )
                  : SizedBox.shrink()
            ]

          ],
        )
    );
  }
}
