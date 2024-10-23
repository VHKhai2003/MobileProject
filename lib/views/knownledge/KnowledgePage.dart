import 'package:flutter/material.dart';
import 'package:code/views/appbar/BuildActions.dart';
import 'package:code/views/drawer/NavigationDrawer.dart' as navigation_drawer;
import './dialog/CreateKnowledge.dart';
import './dialog/AddUnit.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final List<Map<String, dynamic>> _data = [
    {
      "knowledge": "DRL",
      "units": 1,
      "size": "5.79 MB",
      "editTime": "6/10/2024 14:52:23"
    },
    {
      "knowledge": "Flutter",
      "units": 1,
      "size": "1.02 MB",
      "editTime": "6/10/2024 14:44:36"
    },
    {
      "knowledge": "New",
      "units": 1,
      "size": "772.69 KB",
      "editTime": "6/10/2024 21:16:00"
    },
  ];

  String _knowledgeName = '';
  String _knowledgeDescription = '';
  String _selectedUnit = 'Local files'; // Default selected unit

  void _showCreateKnowledgeDialog() {
    showCreateKnowledgeDialog(
      context,
      _data,
      (name) {
        setState(() {
          _knowledgeName = name;
        });
      },
      (description) {
        setState(() {
          _knowledgeDescription = description;
        });
      },
      (unit) {
        setState(() {
          _selectedUnit = unit;
        });
      },
      _selectedUnit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBEFFF),
        actions: buildActions(context),
      ),
      drawer: const SafeArea(child: navigation_drawer.NavigationDrawer()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _showCreateKnowledgeDialog,
                  child: Text('Create Knowledge'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Knowledge')),
                  DataColumn(label: Text('Units')),
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('Edit Time')),
                  DataColumn(label: Text('Action')),
                ],
                rows: _data
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item['knowledge'])),
                          DataCell(Text(item['units'].toString())),
                          DataCell(Text(item['size'])),
                          DataCell(Text(item['editTime'])),
                          DataCell(IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _data.remove(item);
                              });
                            },
                          )),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
