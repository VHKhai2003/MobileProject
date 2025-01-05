import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';
import '../widgets/platform/PlatformTile.dart';
import 'PublishBotState.dart';

class PublishBotDialog extends StatefulWidget {
  final BotProvider botProvider;
  final Bot bot;
  final List<dynamic> configurations;

  const PublishBotDialog({
    super.key,
    required this.botProvider,
    required this.bot,
    required this.configurations,
  });

  @override
  State<PublishBotDialog> createState() => _PublishBotDialogState();
}

class _PublishBotDialogState extends State<PublishBotDialog> {
  late final PublishBotState state;

  @override
  void initState() {
    super.initState();
    state = PublishBotState(widget.configurations);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400,
          minWidth: 300,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildPlatforms(),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Center(
            // Wrap Text with Center widget
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
          right: 5,
          top: 5,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.close, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildPlatforms() {
    return Column(
      children: [
        PlatformTile(
          icon: 'assets/icons/slack.png',
          title: 'Slack',
          state: state,
          platform: 'slack',
          bot: widget.bot,
          botProvider: widget.botProvider,
          onStateChanged: () => setState(() {}),
        ),
        PlatformTile(
          icon: 'assets/icons/telegram.png',
          title: 'Telegram',
          state: state,
          platform: 'telegram',
          bot: widget.bot,
          botProvider: widget.botProvider,
          onStateChanged: () => setState(() {}),
        ),
        PlatformTile(
          icon: 'assets/icons/messenger.png',
          title: 'Messenger',
          state: state,
          platform: 'messenger',
          bot: widget.bot,
          botProvider: widget.botProvider,
          onStateChanged: () => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
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
            onPressed: () =>
                state.handlePublish(context, widget.bot, widget.botProvider),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
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
    );
  }
}
