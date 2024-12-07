class Knowledge {
  String id;
  String knowledgeName;
  String description;
  int numUnits;
  int totalSize; // bytes
  DateTime updatedAt;

  Knowledge(this.id, this.knowledgeName, this.description, this.numUnits, this.totalSize, this.updatedAt,);

  // Ánh xạ từ JSON sang đối tượng Knowledge
  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
      map['id'] as String,
      map['knowledgeName'] as String,
      map['description'] as String,
      map['numUnits'] as int,
      map['totalSize'] as int,
      DateTime.parse(map['updatedAt'] as String),
    );
  }

  // Ánh xạ từ đối tượng Knowledge sang JSON
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
