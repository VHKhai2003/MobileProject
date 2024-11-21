class Assistant {
  final String id;
  final String model;
  final String name;

  Assistant({required this.id, required this.model, required this.name});

  factory Assistant.fromJson(Map<String, dynamic> json) {
    return Assistant(
        id: json['id'],
        model: json['model'],
        name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'name': name,
    };
  }
}
