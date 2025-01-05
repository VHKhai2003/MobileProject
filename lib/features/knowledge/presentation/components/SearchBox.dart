import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    KnowledgeProvider provider = Provider.of<KnowledgeProvider>(context, listen: false);
    return TextField(
      onChanged: (value) async {
        if(value.isEmpty) {
          provider.setLoading(true);
          provider.clearListKnowledge();
          await provider.loadKnowledge('');
          provider.setLoading(false);
        }
      },
      onSubmitted: (value) async {
        focusNode.unfocus();
        provider.setLoading(true);
        provider.clearListKnowledge();
        await provider.loadKnowledge(value);
        provider.setLoading(false);
      },
      cursorColor: Colors.blue.shade700,
      decoration: InputDecoration(
        hintText: 'Find knowledge here...',
        prefixIcon: Icon(Icons.search, color: Colors.grey,),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 1),
        ),
        // suffixIcon: const Icon(Icons.close)
      ),
    );
  }
}
