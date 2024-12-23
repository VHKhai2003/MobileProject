import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/presentation/dialog/SlackConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/MessengerConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/TelegramConfigDialog.dart';

class PublishBotDialog extends StatefulWidget {
  final BotProvider botProvider;
  final Bot bot;
  final List<dynamic> configurations;

  const PublishBotDialog({
    Key? key,
    required this.botProvider,
    required this.bot,
    required this.configurations,
  }) : super(key: key);

  @override
  State<PublishBotDialog> createState() => _PublishBotDialogState();
}

class _PublishBotDialogState extends State<PublishBotDialog> {
  bool slackSelected = false;
  bool telegramSelected = false;
  bool messengerSelected = false;

  bool isSlackVerified = false;
  bool isTelegramVerified = false;
  bool isMessengerVerified = false;

  Map<String, dynamic>? slackConfig;
  Map<String, dynamic>? telegramConfig;
  Map<String, dynamic>? messengerConfig;

  @override
  void initState() {
    super.initState();
    _initializeConfigurations();
  }

  void _initializeConfigurations() {
    for (var config in widget.configurations) {
      switch (config['type']) {
        case 'slack':
          isSlackVerified = config['isVerified'] ?? false;
          if (config['isVerified'] == true) {
            slackConfig = {
              'botToken': config['botToken'],
              'clientId': config['clientId'],
              'clientSecret': config['clientSecret'],
              'signingSecret': config['signingSecret'],
            };
          }
          break;
        case 'telegram':
          isTelegramVerified = config['isVerified'] ?? false;
          if (config['isVerified'] == true) {
            telegramConfig = {
              'botToken': config['botToken'],
            };
          }
          break;
        case 'messenger':
          isMessengerVerified = config['isVerified'] ?? false;
          if (config['isVerified'] == true) {
            messengerConfig = {
              'botToken': config['botToken'],
              'pageId': config['pageId'],
              'appSecret': config['appSecret'],
            };
          }
          break;
      }
    }
  }

  Future<void> _handlePublish() async {
    bool hasError = false;
    List<String> publishedPlatforms = [];

    // Publish lên Slack nếu đã chọn và đã verify
    if (slackSelected && isSlackVerified && slackConfig != null) {
      final success = await widget.botProvider.publishSlackBot(
        widget.bot.id,
        botToken: slackConfig!['botToken'],
        clientId: slackConfig!['clientId'],
        clientSecret: slackConfig!['clientSecret'],
        signingSecret: slackConfig!['signingSecret'],
      );
      if (success) {
        publishedPlatforms.add('Slack');
      } else {
        hasError = true;
      }
    }

    // Publish lên Telegram nếu đã chọn và đã verify
    if (telegramSelected && isTelegramVerified && telegramConfig != null) {
      final success = await widget.botProvider.publishTelegramBot(
        widget.bot.id,
        telegramConfig!['botToken'],
      );
      if (success) {
        publishedPlatforms.add('Telegram');
      } else {
        hasError = true;
      }
    }

    // Publish lên Messenger nếu đã chọn và đã verify
    if (messengerSelected && isMessengerVerified && messengerConfig != null) {
      final success = await widget.botProvider.publishMessengerBot(
        widget.bot.id,
        botToken: messengerConfig!['botToken'],
        pageId: messengerConfig!['pageId'],
        appSecret: messengerConfig!['appSecret'],
      );
      if (success) {
        publishedPlatforms.add('Messenger');
      } else {
        hasError = true;
      }
    }

    // Hiển thị kết quả cho người dùng
    if (context.mounted) {
      if (publishedPlatforms.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn và xác thực ít nhất một nền tảng'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              hasError
                  ? 'Một số nền tảng không thể publish. Đã publish thành công: ${publishedPlatforms.join(", ")}'
                  : 'Đã publish thành công lên: ${publishedPlatforms.join(", ")}',
            ),
            backgroundColor: hasError ? Colors.orange : Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Publishing platform',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            _buildPlatformTile(
              icon: 'assets/icons/slack.png',
              title: 'Slack',
              selected: slackSelected,
              isVerified: isSlackVerified,
              onTap: () => setState(() => slackSelected = !slackSelected),
              configureCallback: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => SlackConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result == true) {
                  setState(() {
                    isSlackVerified = true;
                  });
                }
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/telegram.png',
              title: 'Telegram',
              selected: telegramSelected,
              isVerified: isTelegramVerified,
              onTap: () => setState(() => telegramSelected = !telegramSelected),
              configureCallback: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => TelegramConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result == true) {
                  setState(() {
                    isTelegramVerified = true;
                  });
                }
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/messenger.png',
              title: 'Messenger',
              selected: messengerSelected,
              isVerified: isMessengerVerified,
              onTap: () =>
                  setState(() => messengerSelected = !messengerSelected),
              configureCallback: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => MessengerConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result == true) {
                  setState(() {
                    isMessengerVerified = true;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
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
                      _handlePublish();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: const Text(
                      'Publish',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformTile({
    required String icon,
    required String title,
    required bool selected,
    required bool isVerified,
    required VoidCallback onTap,
    required VoidCallback configureCallback,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: InkWell(
        onTap: isVerified ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: selected,
                  onChanged: isVerified ? (value) => onTap() : null,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 16),
              Image.network(
                icon,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 24,
                    color: Colors.grey,
                  );
                },
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              // Thêm status tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isVerified ? Colors.green[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isVerified ? 'Verified' : 'Not Configured',
                  style: TextStyle(
                    color: isVerified ? Colors.green[700] : Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: configureCallback,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Configure',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
