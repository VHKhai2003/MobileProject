import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Để sao chép nội dung vào clipboard

class MessengerConfigDialog extends StatelessWidget {
  const MessengerConfigDialog({Key? key}) : super(key: key);

  // Hàm sao chép nội dung vào clipboard
  void _copyToClipboard(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied to clipboard!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Configure Messenger Bot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Connect to Messenger Bots and chat with this bot in Messenger App',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Xử lý "How to obtain Messenger configurations?"
                },
                child: Text(
                  'How to obtain Messenger configurations?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Messenger copylink section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Messenger copylink',
                description:
                    'Copy the following content to your Messenger app configuration page.',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'Callback URL',
                'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/91f84829-132b-4522-a4e4-03352edf13a1',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'Verify Token',
                'knowledge',
              ),
              const SizedBox(height: 16),

              // Messenger information section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Messenger information',
                description: '',
              ),
              const SizedBox(height: 8),
              _buildInputField('Messenger Bot Token'),
              _buildInputField('Messenger Bot Page ID'),
              _buildInputField('Messenger Bot App Secret'),
              const SizedBox(height: 16),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      // Xử lý "OK"
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 4),
            child: Text(
              description,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
      ],
    );
  }

  Widget _buildUrlRow(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, size: 20, color: Colors.blue),
              onPressed: () {
                _copyToClipboard(context, content); // Gọi hàm sao chép
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: 'Enter $title',
            ),
          ),
        ],
      ),
    );
  }
}
