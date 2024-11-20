import 'package:code/features/chat/models/ChatHistoryDetail.dart';

class ConversationHistory {
  final String cursor;
  final bool hasMore;
  final int limit;
  final List<ChatHistoryDetail> items;
  final String id;

  ConversationHistory({required this.cursor, required this.hasMore, required this.limit, required this.items, required this.id});

  factory ConversationHistory.fromJson(Map<String, dynamic> json, String id) {
    return ConversationHistory(
      id: id,
      cursor: json['cursor'],
      hasMore: json['has_more'],
      limit: json['limit'],
      items: (json['items'] as List).map((item) => ChatHistoryDetail.fromJson(item)).toList(),
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
