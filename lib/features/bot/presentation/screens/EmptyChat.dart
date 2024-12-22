import 'package:flutter/material.dart';

class EmptyChat extends StatelessWidget {
  final String botName;
  final TextEditingController chatController;

  const EmptyChat({
    Key? key,
    required this.botName,
    required this.chatController,
  }) : super(key: key);

  void _insertSuggestion(String text) {
    chatController.text = text;
    chatController.selection = TextSelection.fromPosition(
      TextPosition(offset: chatController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon và tiêu đề
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 48,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start askking the $botName some things now',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Select a suggestion or input your question',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            _buildSuggestionButton(
              'Please summarize the following content for me',
              Icons.analytics_outlined,
            ),
            const SizedBox(height: 12),
            _buildSuggestionButton(
              'Translate the following language into',
              Icons.code_outlined,
            ),
            const SizedBox(height: 12),
            _buildSuggestionButton(
              'Explain this concept to me',
              Icons.lightbulb_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionButton(String text, IconData icon) {
    return InkWell(
      onTap: () => _insertSuggestion(text),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
