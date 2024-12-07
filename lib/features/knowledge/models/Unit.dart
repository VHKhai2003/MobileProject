class Unit {
  String id;
  String name;
  String type;
  int size;
  DateTime createdAt;
  bool status;
  Unit(this.id, this.name, this.type, this.size, this.createdAt, this.status);

  // mapping from json
  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      map['id'] as String,
      map['name'] as String,
      map['type'] as String,
      map['size'] as int,
      DateTime.parse(map['createdAt'] as String),
      map["status"] as bool
    );
  }

}