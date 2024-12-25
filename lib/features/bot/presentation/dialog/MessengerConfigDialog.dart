import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class MessengerConfigDialog extends StatefulWidget {
  final Bot bot;
  final BotProvider botProvider;

  const MessengerConfigDialog({
    Key? key,
    required this.bot,
    required this.botProvider,
  }) : super(key: key);

  @override
  State<MessengerConfigDialog> createState() => _MessengerConfigDialogState();
}

class _MessengerConfigDialogState extends State<MessengerConfigDialog> {
  final TextEditingController _botTokenController = TextEditingController();
  final TextEditingController _pageIdController = TextEditingController();
  final TextEditingController _appSecretController = TextEditingController();
  bool _isVerifying = false;
  String? _errorMessage;

  @override
  void dispose() {
    _botTokenController.dispose();
    _pageIdController.dispose();
    _appSecretController.dispose();
    super.dispose();
  }

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

  Future<void> _verifyMessenger() async {
    if (_botTokenController.text.isEmpty ||
        _pageIdController.text.isEmpty ||
        _appSecretController.text.isEmpty) {
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
      final response = await widget.botProvider.verifyMessengerBot(
        widget.bot.id,
        botToken: _botTokenController.text,
        pageId: _pageIdController.text,
        appSecret: _appSecretController.text,
      );

      if (response) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Messenger configuration verified successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Trả về cả trạng thái verify và thông tin cấu hình
          Navigator.pop(context, {
            'verified': true,
            'config': {
              'botToken': _botTokenController.text,
              'pageId': _pageIdController.text,
              'appSecret': _appSecretController.text,
            }
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage =
                'Failed to verify Messenger configuration. Please check your credentials and try again.';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to verify Messenger configuration'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: Failed to verify Messenger configuration';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while verifying configuration'),
            backgroundColor: Colors.red,
          ),
        );
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
                _copyToClipboard(context, content);
              },
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
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
                onTap: () async {
                  final Uri url = Uri.parse(
                      'https://jarvis.cx/help/knowledge-base/publish-bot/messenger');
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
                'https://knowledge-api.dev.jarvis.cx/kb-core/v1/hook/messenger/${widget.bot.id}',
              ),
              const SizedBox(height: 8),
              _buildUrlRow(
                context,
                'Verify Token',
                'knowledge',
              ),
              const SizedBox(height: 16),
              _buildInfoSection(
                icon: Icons.info_outline,
                title: 'Messenger information',
                description: '',
              ),
              const SizedBox(height: 8),
              _buildInputField('Messenger Bot Token', _botTokenController),
              _buildInputField('Messenger Bot Page ID', _pageIdController),
              _buildInputField(
                  'Messenger Bot App Secret', _appSecretController),
              const SizedBox(height: 16),
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
                    onPressed: _isVerifying ? null : _verifyMessenger,
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
