import 'package:code/features/chat/models/ChatHistoryInfo.dart';

class Conversations {
  final String cursor;
  final bool hasMore;
  final int limit;
  final List<ChatHistoryInfo> items;

  Conversations({required this.cursor, required this.hasMore, required this.limit, required this.items});

  factory Conversations.fromJson(Map<String, dynamic> json) {
    return Conversations(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      limit: json['limit'],
      items: (json['items'] as List).map((item) => ChatHistoryInfo.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cursor': cursor,
      'has_more': hasMore,
      'limit': limit,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
