import 'package:flutter/material.dart';

class EmptyConversation extends StatelessWidget {
  const EmptyConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ListView(
          children: [
            const Text("👋", style: TextStyle(fontSize: 36, color: Colors.yellow),),
            const Text("Hello, Good morning", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),),
            const Text("I'm Jarvis, your personal assistant"),
            const SizedBox(height: 32,),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("You don't know what to say, use a prompt", style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 100, 116, 139)),),
                      Text("View all...", style: TextStyle(fontSize: 13, color: Colors.blue),),
                    ],
                  ),
                ),
                Container(
                  child: const Column(
                    children: [
                      _PromptItem(),
                      _PromptItem(),
                      _PromptItem(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptItem extends StatelessWidget {
  const _PromptItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Translate sentence"),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward, color: Colors.blue, size: 16,))
        ],
      ),
    );
  }
}

