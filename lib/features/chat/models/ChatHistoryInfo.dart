class ChatHistoryInfo {
  final String title;
  final String id;
  final int createdAt;

  ChatHistoryInfo({required this.title, required this.id, required this.createdAt});

  factory ChatHistoryInfo.fromJson(Map<String, dynamic> json) {
    return ChatHistoryInfo(
      title: json['title'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'createdAt': createdAt,
    };
  }
}
