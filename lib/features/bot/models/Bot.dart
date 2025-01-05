class Bot {
  final String id;
  final String name;
  final String? description;
  final String? instructions;
  final String createdAt;
  final String updatedAt;
  final List<String>? knowledge;
  final String openAiAssistantId;
  final String openAiThreadIdPlay;
  final String openAiVectorStoreId;

  Bot({
    required this.id,
    required this.name,
    this.description,
    this.instructions,
    required this.createdAt,
    required this.updatedAt,
    this.knowledge,
    required this.openAiAssistantId,
    required this.openAiThreadIdPlay,
    required this.openAiVectorStoreId,
  });

  factory Bot.fromMap(Map<String, dynamic> map) {
    return Bot(
      id: map['id'] ?? '',
      name: map['assistantName'] ?? '',
      description: map['description'],
      instructions: map['instructions'],
      createdAt: DateTime.parse(map['createdAt']).toString(),
      updatedAt: DateTime.parse(map['updatedAt']).toString(),
      knowledge: [],
      openAiAssistantId: map['openAiAssistantId'] ?? '',
      openAiThreadIdPlay: map['openAiThreadIdPlay'] ?? '',
      openAiVectorStoreId: map['openAiVectorStoreId'] ?? '',
    );
  }
}
