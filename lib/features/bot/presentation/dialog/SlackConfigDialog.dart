import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SlackConfigDialog extends StatelessWidget {
  const SlackConfigDialog({Key? key}) : super(key: key);

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
                    'Configure Slack Bot',
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
                'Connect to Slack Bots and chat with this bot in Slack App',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Handle "How to obtain Slack configurations?"
                },
                child: Text(
                  'How to obtain Slack configurations?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Slack copylink section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Slack copylink',
                description:
                    'Copy the following content to your Slack app configuration page.',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'OAuth2 Redirect URLs',
                'https://knowledge-api.jarvis.cx/kb-core/v1/bot-integration/slack/auth/91f84829-132b-4522-a4e4-03352edf13a1',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'Event Request URL',
                'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/91f84829-132b-4522-a4e4-03352edf13a1',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'Slash Request URL',
                'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/slash/91f84829-132b-4522-a4e4-03352edf13a1',
              ),
              const SizedBox(height: 16),

              // Slack information section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Slack information',
                description: '',
              ),
              const SizedBox(height: 8),
              _buildInputField('Token'),
              _buildInputField('Client ID'),
              _buildInputField('Client Secret'),
              _buildInputField('Signing Secret'),
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
                      // Handle "OK" action
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

  Widget _buildUrlRow(BuildContext context, String title, String url) {
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
                url,
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
                _copyToClipboard(context, url); // Gọi hàm sao chép
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
