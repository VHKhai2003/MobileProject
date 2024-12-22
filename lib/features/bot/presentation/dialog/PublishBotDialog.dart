import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/presentation/dialog/SlackConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/MessengerConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/TelegramConfigDialog.dart';

class PublishBotDialog extends StatefulWidget {
  final BotProvider botProvider;
  final Bot bot;

  const PublishBotDialog({
    Key? key,
    required this.botProvider,
    required this.bot,
  }) : super(key: key);

  @override
  State<PublishBotDialog> createState() => _PublishBotDialogState();
}

class _PublishBotDialogState extends State<PublishBotDialog> {
  bool slackSelected = false;
  bool telegramSelected = false;
  bool messengerSelected = false;

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
              onTap: () => setState(() => slackSelected = !slackSelected),
              configureCallback: () {
                showDialog(
                  context: context,
                  builder: (context) => const SlackConfigDialog(),
                );
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/telegram.png',
              title: 'Telegram',
              selected: telegramSelected,
              onTap: () => setState(() => telegramSelected = !telegramSelected),
              configureCallback: () {
                showDialog(
                  context: context,
                  builder: (context) => const TelegramConfigDialog(),
                );
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/messenger.png',
              title: 'Messenger',
              selected: messengerSelected,
              onTap: () =>
                  setState(() => messengerSelected = !messengerSelected),
              configureCallback: () {
                showDialog(
                  context: context,
                  builder: (context) => const MessengerConfigDialog(),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformTile({
    required String icon,
    required String title,
    required bool selected,
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
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: selected,
                  onChanged: (value) => onTap(),
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
