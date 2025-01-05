import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/presentation/publish-bot-dialog/SlackConfigDialog.dart';
import 'package:code/features/bot/presentation/publish-bot-dialog/TelegramConfigDialog.dart';
import 'package:code/features/bot/presentation/publish-bot-dialog/MessengerConfigDialog.dart';
import '../../publish-bot-dialog/PublishBotState.dart';

class PlatformTile extends StatelessWidget {
  final String icon;
  final String title;
  final String platform;
  final PublishBotState state;
  final Bot bot;
  final BotProvider botProvider;
  final VoidCallback onStateChanged;

  const PlatformTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.platform,
    required this.state,
    required this.bot,
    required this.botProvider,
    required this.onStateChanged,
  }) : super(key: key);

  bool get isSelected {
    switch (platform) {
      case 'slack':
        return state.slackSelected;
      case 'telegram':
        return state.telegramSelected;
      case 'messenger':
        return state.messengerSelected;
      default:
        return false;
    }
  }

  bool get isVerified {
    switch (platform) {
      case 'slack':
        return state.isSlackVerified;
      case 'telegram':
        return state.isTelegramVerified;
      case 'messenger':
        return state.isMessengerVerified;
      default:
        return false;
    }
  }

  bool get isPublished {
    switch (platform) {
      case 'slack':
        return state.isSlackPublished;
      case 'telegram':
        return state.isTelegramPublished;
      case 'messenger':
        return state.isMessengerPublished;
      default:
        return false;
    }
  }

  String? get redirectUrl {
    switch (platform) {
      case 'slack':
        return state.slackConfig?['redirect'];
      case 'telegram':
        return state.telegramConfig?['redirect'];
      case 'messenger':
        return state.messengerConfig?['redirect'];
      default:
        return null;
    }
  }

  void _toggleSelection() {
    switch (platform) {
      case 'slack':
        state.slackSelected = !state.slackSelected;
        break;
      case 'telegram':
        state.telegramSelected = !state.telegramSelected;
        break;
      case 'messenger':
        state.messengerSelected = !state.messengerSelected;
        break;
    }
    onStateChanged();
  }

  Future<void> _handleConfigure(BuildContext context) async {
    Widget dialog;
    switch (platform) {
      case 'slack':
        dialog = SlackConfigDialog(bot: bot, botProvider: botProvider);
        break;
      case 'telegram':
        dialog = TelegramConfigDialog(bot: bot, botProvider: botProvider);
        break;
      case 'messenger':
        dialog = MessengerConfigDialog(bot: bot, botProvider: botProvider);
        break;
      default:
        return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => dialog,
    );

    if (result != null && result['verified'] == true) {
      switch (platform) {
        case 'slack':
          state.isSlackVerified = true;
          state.slackConfig = result['config'];
          break;
        case 'telegram':
          state.isTelegramVerified = true;
          state.telegramConfig = result['config'];
          break;
        case 'messenger':
          state.isMessengerVerified = true;
          state.messengerConfig = result['config'];
          break;
      }
      onStateChanged();
    }
  }

  Future<void> _handleDisconnect(BuildContext context) async {
    final shouldDisconnect = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Disconnect $title'),
        content: Text(
          'Are you sure you want to disconnect this bot integration?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red[700],
            ),
            child: Text('Disconnect'),
          ),
        ],
      ),
    );

    if (shouldDisconnect == true) {
      final success = await botProvider.disconnectBot(
        bot.id,
        platform,
      );

      if (context.mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully disconnected $title integration'),
              backgroundColor: Colors.green,
            ),
          );
          _resetPlatformState();
          onStateChanged();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to disconnect $title integration'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _resetPlatformState() {
    switch (platform) {
      case 'slack':
        state.isSlackVerified = false;
        state.isSlackPublished = false;
        state.slackConfig = null;
        state.slackSelected = false;
        break;
      case 'telegram':
        state.isTelegramVerified = false;
        state.isTelegramPublished = false;
        state.telegramConfig = null;
        state.telegramSelected = false;
        break;
      case 'messenger':
        state.isMessengerVerified = false;
        state.isMessengerPublished = false;
        state.messengerConfig = null;
        state.messengerSelected = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = isPublished
        ? Colors.green[700]
        : isVerified
            ? Colors.blue[700]
            : Colors.grey[700];

    final bgColor = isPublished
        ? Colors.green[50]
        : isVerified
            ? Colors.blue[50]
            : Colors.grey[100];

    final bool canCheck = isVerified && !isPublished;
    final bool checkboxValue = isPublished ? true : isSelected;

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
        onTap: canCheck ? _toggleSelection : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: checkboxValue,
                      onChanged: canCheck
                          ? (bool? value) {
                              if (value != null) {
                                _toggleSelection();
                              }
                            }
                          : null,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    icon, // Sử dụng trực tiếp icon string path
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported,
                          size: 20, color: Colors.grey);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isPublished
                          ? 'Published'
                          : isVerified
                              ? 'Verified'
                              : 'Not Configured',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (isPublished || !isVerified)
                Padding(
                  padding: EdgeInsets.only(left: 32, top: 4),
                  child: Row(
                    children: [
                      if (isPublished) ...[
                        if (redirectUrl != null)
                          TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(redirectUrl!);
                              if (!await launchUrl(url)) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Could not open app page'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              minimumSize: Size(0, 0),
                              foregroundColor: Colors.blue[700],
                            ),
                            child: Text(
                              'Your App',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: () => _handleDisconnect(context),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size(0, 0),
                            foregroundColor: Colors.red[700],
                          ),
                          child: Text(
                            'Disconnect',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ] else
                        TextButton(
                          onPressed: () => _handleConfigure(context),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size(0, 0),
                            foregroundColor: Colors.blue[700],
                          ),
                          child: Text(
                            'Configure',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
