class Prompt {
  String id;
  String title;
  String content;
  bool isFavorite;
  bool isPublic;
  String description;
  String category;
  Prompt(this.id, this.title, this.content, this.isPublic, this.isFavorite, {this.description = '', this.category = 'other'});


  // Factory method to create a Prompt from JSON
  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      json['_id'],
      json['title'],
      json['content'],
      json['isPublic'],
      json['isFavorite'],
      description: json['description'] ?? '',
      category: json['category'] ?? 'other',
    );
  }
}
