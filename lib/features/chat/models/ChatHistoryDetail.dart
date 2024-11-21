class ChatHistoryDetail {
  final String answer;
  final String query;
  final int createdAt;
  final List files;

  ChatHistoryDetail({required this.answer, required this.query, required this.createdAt, required this.files});

  factory ChatHistoryDetail.fromJson(Map<String, dynamic> json) {
    return ChatHistoryDetail(
      answer: json['answer'],
      query: json['query'],
      createdAt: json['createdAt'],
      files: json['files']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'query': query,
      'createdAt': createdAt,
      'files': files
    };
  }
}
