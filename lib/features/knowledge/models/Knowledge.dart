class Knowledge {
  String id;
  String knowledgeName;
  String description;
  int numUnits;
  int totalSize;
  DateTime updatedAt;

  Knowledge(
    this.id,
    this.knowledgeName,
    this.description,
    this.numUnits,
    this.totalSize,
    this.updatedAt,
  );

  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
      map['id'] as String? ?? '',
      map['knowledgeName'] as String? ?? '',
      map['description'] as String? ?? '',
      map['numUnits'] as int? ?? 0,
      map['totalSize'] as int? ?? 0,
      map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'knowledgeName': knowledgeName,
      'description': description,
      'numUnits': numUnits,
      'totalSize': totalSize,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
