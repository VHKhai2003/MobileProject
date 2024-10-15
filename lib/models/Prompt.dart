class Prompt {
  String name;
  String content;
  bool isPrivate;
  bool isFavorite;
  String description;
  String category;
  Prompt(this.name, this.content, this.isPrivate, this.category, {this.description = '', this.isFavorite = false});
}