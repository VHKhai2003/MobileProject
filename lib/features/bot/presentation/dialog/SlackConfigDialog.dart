import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class SlackConfigDialog extends StatefulWidget {
  final Bot bot;
  final BotProvider botProvider;

  const SlackConfigDialog({
    Key? key,
    required this.bot,
    required this.botProvider,
  }) : super(key: key);

  @override
  State<SlackConfigDialog> createState() => _SlackConfigDialogState();
}

class _SlackConfigDialogState extends State<SlackConfigDialog> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _clientSecretController = TextEditingController();
  final TextEditingController _signingSecretController =
      TextEditingController();
  bool _isVerifying = false;
  String? _errorMessage;

  @override
  void dispose() {
    _tokenController.dispose();
    _clientIdController.dispose();
    _clientSecretController.dispose();
    _signingSecretController.dispose();
    super.dispose();
  }

  void _copyToClipboard(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Copied to clipboard!', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _verifySlack() async {
    if (_tokenController.text.isEmpty ||
        _clientIdController.text.isEmpty ||
        _clientSecretController.text.isEmpty ||
        _signingSecretController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    try {
      final response = await widget.botProvider.verifySlackBot(
        widget.bot.id,
        botToken: _tokenController.text,
        clientId: _clientIdController.text,
        clientSecret: _clientSecretController.text,
        signingSecret: _signingSecretController.text,
      );

      if (mounted) {
        if (response) {
          Navigator.pop(context, true);
        } else {
          setState(() {
            _errorMessage =
                'Verification failed. Please check your credentials and try again.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: Failed to verify Slack configuration';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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

  Widget _buildUrlRow(String title, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
              onPressed: () => _copyToClipboard(context, url),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: 'Enter $title',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                onTap: () async {
                  final Uri url = Uri.parse(
                      'https://jarvis.cx/help/knowledge-base/publish-bot/slack');
                  if (!await launchUrl(url)) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not open help page'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
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

              if (_errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red[700], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              // Slack copylink section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Slack copylink',
                description:
                    'Copy the following content to your Slack app configuration page.',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                'OAuth2 Redirect URLs',
                'https://knowledge-api.dev.jarvis.cx/kb-core/v1/bot-integration/slack/auth/${widget.bot.id}',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                'Event Request URL',
                'https://knowledge-api.dev.jarvis.cx/kb-core/v1/hook/slack/${widget.bot.id}',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                'Slash Request URL',
                'https://knowledge-api.dev.jarvis.cx/kb-core/v1/hook/slack/slash/${widget.bot.id}',
              ),
              const SizedBox(height: 16),

              // Slack information section
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Slack information',
                description: '',
              ),
              const SizedBox(height: 8),
              _buildInputField('Token', _tokenController),
              _buildInputField('Client ID', _clientIdController),
              _buildInputField('Client Secret', _clientSecretController),
              _buildInputField('Signing Secret', _signingSecretController),
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
                    onPressed: _isVerifying ? null : _verifySlack,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: _isVerifying
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Verify',
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
}
