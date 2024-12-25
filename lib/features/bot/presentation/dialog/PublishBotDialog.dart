import 'package:flutter/material.dart';
import 'package:code/features/bot/provider/BotProvider.dart';
import 'package:code/features/bot/models/Bot.dart';
import 'package:code/features/bot/presentation/dialog/SlackConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/MessengerConfigDialog.dart';
import 'package:code/features/bot/presentation/dialog/TelegramConfigDialog.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool isSlackPublished = false; // Thêm trạng thái published
  bool isTelegramPublished = false;
  bool isMessengerPublished = false;

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
      final type = config['type'];
      final metadata = config['metadata'];
      switch (type) {
        case 'slack':
          isSlackVerified = true;
          isSlackPublished = true;
          slackConfig = {
            'botToken': metadata['botToken'],
            'clientId': metadata['clientId'],
            'clientSecret': metadata['clientSecret'],
            'signingSecret': metadata['signingSecret'],
            'redirect': metadata['redirect'],
          };
          break;

        case 'telegram':
          isTelegramVerified = true;
          isTelegramPublished = true;
          telegramConfig = {
            'botToken': metadata['botToken'],
            'redirect': metadata['redirect'],
          };
          break;

        case 'messenger':
          isMessengerVerified = true;
          isMessengerPublished = true;
          messengerConfig = {
            'botToken': metadata['botToken'],
            'pageId': metadata['pageId'],
            'appSecret': metadata['appSecret'],
            'redirect': metadata['redirect'],
          };
          break;
      }
    }
  }

  Future<void> _handlePublish() async {
    print('Starting publish process...');
    bool hasError = false;
    List<String> publishedPlatforms = [];

    print('Messenger states:');
    print('messengerSelected: $messengerSelected');
    print('isMessengerVerified: $isMessengerVerified');
    print('messengerConfig: $messengerConfig');

    // Kiểm tra xem có platform nào được chọn không
    if (!slackSelected && !telegramSelected && !messengerSelected) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ít nhất một nền tảng'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    // Hiển thị loading indicator
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('Publishing...'),
                ],
              ),
            ),
          );
        },
      );
    }

    try {
      if (slackSelected && isSlackVerified && slackConfig != null) {
        print('Publishing to Slack...');
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

      if (telegramSelected && isTelegramVerified && telegramConfig != null) {
        print('Publishing to Telegram...');
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

      if (messengerSelected && isMessengerVerified && messengerConfig != null) {
        print('Publishing to Messenger...');
        print('Config: $messengerConfig');
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

      // Đóng dialog loading
      if (context.mounted) {
        Navigator.pop(context); // Đóng loading dialog

        if (publishedPlatforms.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không có nền tảng nào được publish thành công'),
              backgroundColor: Colors.red,
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
          Navigator.pop(context, true); // Đóng publish dialog
        }
      }
    } catch (e) {
      print('Error during publish: $e');
      if (context.mounted) {
        Navigator.pop(context); // Đóng loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra trong quá trình publish'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Widget _buildPlatformTile({
  //   required String icon,
  //   required String title,
  //   required bool selected,
  //   required bool isVerified,
  //   required VoidCallback onTap,
  //   required VoidCallback configureCallback,
  //   required bool isPublished,
  //   String? redirectUrl, // Thêm tham số redirectUrl
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       border: Border(
  //         bottom: BorderSide(
  //           color: Colors.grey[300]!,
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     child: InkWell(
  //       onTap: (isVerified || isPublished) ? onTap : null,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //         child: Row(
  //           children: [
  //             SizedBox(
  //               width: 24,
  //               height: 24,
  //               child: Checkbox(
  //                 value: selected,
  //                 onChanged: (isVerified || isPublished)
  //                     ? (bool? value) {
  //                         if (value != null) {
  //                           onTap();
  //                         }
  //                       }
  //                     : null,
  //                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //               ),
  //             ),
  //             const SizedBox(width: 16),
  //             Image.network(
  //               icon,
  //               width: 24,
  //               height: 24,
  //               fit: BoxFit.contain,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return Icon(
  //                   Icons.image_not_supported,
  //                   size: 24,
  //                   color: Colors.grey,
  //                 );
  //               },
  //             ),
  //             const SizedBox(width: 12),
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const SizedBox(width: 12),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: isPublished
  //                     ? Colors.green[50]
  //                     : isVerified
  //                         ? Colors.blue[50]
  //                         : Colors.grey[100],
  //                 borderRadius: BorderRadius.circular(4),
  //               ),
  //               child: Text(
  //                 isPublished
  //                     ? 'Published'
  //                     : isVerified
  //                         ? 'Verified'
  //                         : 'Not Configured',
  //                 style: TextStyle(
  //                   color: isPublished
  //                       ? Colors.green[700]
  //                       : isVerified
  //                           ? Colors.blue[700]
  //                           : Colors.grey[700],
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ),
  //             Spacer(),
  //             // Thay đổi nút Configure/YourApp dựa trên trạng thái
  //             if (isPublished && redirectUrl != null)
  //               TextButton(
  //                 onPressed: () async {
  //                   final Uri url = Uri.parse(redirectUrl);
  //                   if (!await launchUrl(url)) {
  //                     if (context.mounted) {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         const SnackBar(
  //                           content: Text('Could not open app page'),
  //                           backgroundColor: Colors.red,
  //                         ),
  //                       );
  //                     }
  //                   }
  //                 },
  //                 style: TextButton.styleFrom(
  //                   padding: EdgeInsets.zero,
  //                   minimumSize: Size(0, 0),
  //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                 ),
  //                 child: Text(
  //                   'Your App',
  //                   style: TextStyle(
  //                     color: Colors.blue,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               )
  //             else
  //               TextButton(
  //                 onPressed: configureCallback,
  //                 style: TextButton.styleFrom(
  //                   padding: EdgeInsets.zero,
  //                   minimumSize: Size(0, 0),
  //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                 ),
  //                 child: Text(
  //                   'Configure',
  //                   style: TextStyle(
  //                     color: Colors.blue,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPlatformTile({
    required String icon,
    required String title,
    required bool selected,
    required bool isVerified,
    required VoidCallback onTap,
    required VoidCallback configureCallback,
    required bool isPublished,
    String? redirectUrl,
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
        onTap: (isVerified || isPublished) ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: selected,
                  onChanged: (isVerified || isPublished)
                      ? (bool? value) {
                          if (value != null) {
                            onTap();
                          }
                        }
                      : null,
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
                  return Icon(Icons.image_not_supported,
                      size: 24, color: Colors.grey);
                },
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPublished
                      ? Colors.green[50]
                      : isVerified
                          ? Colors.blue[50]
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isPublished
                      ? 'Published'
                      : isVerified
                          ? 'Verified'
                          : 'Not Configured',
                  style: TextStyle(
                    color: isPublished
                        ? Colors.green[700]
                        : isVerified
                            ? Colors.blue[700]
                            : Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
              Spacer(),
              if (isPublished)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (redirectUrl != null)
                      TextButton(
                        onPressed: () async {
                          final Uri url = Uri.parse(redirectUrl);
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
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Your App',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () async {
                        final shouldDisconnect = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Disconnect $title'),
                            content: Text(
                                'Are you sure you want to disconnect this bot integration?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: Text('Disconnect'),
                              ),
                            ],
                          ),
                        );

                        if (shouldDisconnect == true) {
                          final success =
                              await widget.botProvider.disconnectBot(
                            widget.bot.id,
                            title.toLowerCase(),
                          );

                          if (context.mounted) {
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Successfully disconnected $title integration'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Cập nhật lại UI và trạng thái
                              setState(() {
                                switch (title.toLowerCase()) {
                                  case 'slack':
                                    isSlackVerified = false;
                                    isSlackPublished = false;
                                    slackConfig = null;
                                    slackSelected = false;
                                    break;
                                  case 'telegram':
                                    isTelegramVerified = false;
                                    isTelegramPublished = false;
                                    telegramConfig = null;
                                    telegramSelected = false;
                                    break;
                                  case 'messenger':
                                    isMessengerVerified = false;
                                    isMessengerPublished = false;
                                    messengerConfig = null;
                                    messengerSelected = false;
                                    break;
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to disconnect $title integration'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.red,
                      ),
                      child: Text(
                        'Disconnect',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              else
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
              isPublished: isSlackPublished,
              redirectUrl: slackConfig?['redirect'],
              onTap: () => setState(() => slackSelected = !slackSelected),
              configureCallback: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => SlackConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result != null && result['verified'] == true) {
                  setState(() {
                    isSlackVerified = true;
                    slackConfig = result['config'];
                  });
                }
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/telegram.png',
              title: 'Telegram',
              selected: telegramSelected,
              isVerified: isTelegramVerified,
              isPublished: isTelegramPublished,
              redirectUrl: telegramConfig?['redirect'],
              onTap: () => setState(() => telegramSelected = !telegramSelected),
              configureCallback: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => TelegramConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result != null && result['verified'] == true) {
                  setState(() {
                    isTelegramVerified = true;
                    telegramConfig = result['config'];
                  });
                }
              },
            ),
            _buildPlatformTile(
              icon: 'assets/icons/messenger.png',
              title: 'Messenger',
              selected: messengerSelected,
              isVerified: isMessengerVerified,
              isPublished: isMessengerPublished,
              redirectUrl: messengerConfig?['redirect'],
              onTap: () {
                print('Messenger tile tapped');
                print('Current selected state: $messengerSelected');
                setState(() {
                  messengerSelected = !messengerSelected;
                });
                print('New selected state: $messengerSelected');
              },
              configureCallback: () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => MessengerConfigDialog(
                    bot: widget.bot,
                    botProvider: widget.botProvider,
                  ),
                );

                if (result != null && result['verified'] == true) {
                  setState(() {
                    isMessengerVerified = true;
                    messengerConfig = result['config'];
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
                    onPressed: () => _handlePublish(),
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
}
