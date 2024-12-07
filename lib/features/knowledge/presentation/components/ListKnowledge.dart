import 'package:code/features/knowledge/models/Knowledge.dart';
import 'package:code/features/knowledge/presentation/components/KnowledgeElement.dart';
import 'package:code/features/knowledge/providers/KnowledgeProvider.dart';
import 'package:flutter/material.dart';
import 'package:code/features/knowledge/presentation/components/CreateKnowledgeButton.dart';
import 'package:code/features/knowledge/presentation/components/SearchBox.dart';
import 'package:provider/provider.dart';

class ListKnowledge extends StatefulWidget {
  const ListKnowledge({super.key});

  @override
  State<ListKnowledge> createState() => _ListKnowledgeState();
}

class _ListKnowledgeState extends State<ListKnowledge> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initData();
    });
  }

  Future<void> initData() async {
    KnowledgeProvider provider =
        Provider.of<KnowledgeProvider>(context, listen: false);
    provider.setLoading(true);
    provider.clearListKnowledge();
    try {
      await provider.loadKnowledge('');
    } catch (e) {
    } finally {
      provider.setLoading(false);
    }
  }

  Future<void> fetchData() async {
    KnowledgeProvider provider =
        Provider.of<KnowledgeProvider>(context, listen: false);
    provider.setLoading(true);
    try {
      await provider.loadKnowledge('');
    } catch (e) {
    } finally {
      provider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    KnowledgeProvider knowledgeProvider =
        Provider.of<KnowledgeProvider>(context);
    List<Knowledge> knowledges = knowledgeProvider.knowledges;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SearchBox(),
            ),
            // CreateKnowledgeButton(createNewKnowledge: createNewKnowledge),
            if (knowledges.isNotEmpty) ...[
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: knowledges.length,
                  itemBuilder: (context, index) {
                    return KnowledgeElement(knowledge: knowledges[index]);
                  },
                  // padding: const EdgeInsets.all(10),
                ),
              ),
              knowledgeProvider.hasNext
                  ? TextButton(
                      onPressed: () {fetchData();},
                      child: Text('More...', style: TextStyle(color: Colors.blue),))
                  : SizedBox.shrink()
            ] else if (knowledgeProvider.isLoading) ...[
              Expanded(
                  child: Center(child: CircularProgressIndicator(),)
              )
            ] else ...[
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
                "Create a knowledge base to store your data and manage your units.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ));
  }
}
