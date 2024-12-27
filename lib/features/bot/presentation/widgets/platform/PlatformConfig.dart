class PlatformConfig {
  final String type;
  final Map<String, dynamic> metadata;

  PlatformConfig({required this.type, required this.metadata});

  Map<String, dynamic>? get config {
    switch (type) {
      case 'slack':
        return {
          'botToken': metadata['botToken'],
          'clientId': metadata['clientId'],
          'clientSecret': metadata['clientSecret'],
          'signingSecret': metadata['signingSecret'],
          'redirect': metadata['redirect'],
        };
      case 'telegram':
        return {
          'botToken': metadata['botToken'],
          'redirect': metadata['redirect'],
        };
      case 'messenger':
        return {
          'botToken': metadata['botToken'],
          'pageId': metadata['pageId'],
          'appSecret': metadata['appSecret'],
          'redirect': metadata['redirect'],
        };
      default:
        return null;
    }
  }
}

class PublishBotState {
  final bool selected;
  final bool isVerified;
  final bool isPublished;
  final Map<String, dynamic>? config;

  PublishBotState({
    required this.selected,
    required this.isVerified,
    required this.isPublished,
    this.config,
  });

  PublishBotState copyWith({
    bool? selected,
    bool? isVerified,
    bool? isPublished,
    Map<String, dynamic>? config,
  }) {
    return PublishBotState(
      selected: selected ?? this.selected,
      isVerified: isVerified ?? this.isVerified,
      isPublished: isPublished ?? this.isPublished,
      config: config ?? this.config,
    );
  }
}
