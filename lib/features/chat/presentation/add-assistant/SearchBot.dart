import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBot extends StatefulWidget {
  const SearchBot({super.key});

  @override
  _SearchBotState createState() => _SearchBotState();
}

class _SearchBotState extends State<SearchBot> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    BotProvider provider = Provider.of<BotProvider>(context, listen: false);
    return TextField(
      onChanged: (value) async {
        if(value.isEmpty) {
          provider.setLoading(true);
          provider.clearListBot();
          await provider.loadBots('');
          provider.setLoading(false);
        }
      },
      onSubmitted: (value) async {
        focusNode.unfocus();
        provider.setLoading(true);
        provider.clearListBot();
        await provider.loadBots(value);
        provider.setLoading(false);
      },
      cursorColor: Colors.blue.shade700,
      decoration: InputDecoration(
        hintText: 'Find bots here...',
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
