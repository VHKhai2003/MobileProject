import 'package:code/features/chat/models/Assistant.dart';

class Message {
  final String role;
  final String content;
  final Assistant assistant;
  final bool? isErrored;

  Message({required this.role, required this.content, required this.assistant, this.isErrored});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
      assistant: json['assistant'],
      isErrored: json['isErrored'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'assistant': assistant,
      'isErrored': isErrored,
    };
  }
}
