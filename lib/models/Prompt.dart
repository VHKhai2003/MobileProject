class Prompt {
  String name;
  String content;
  bool isFavorite;

  Prompt(this.name, this.content, this.isFavorite);
}

class PrivatePrompt extends Prompt {
  PrivatePrompt(super.name, super.content, super.isFavorite, );
}

class PublicPrompt extends Prompt {
  String description;
  String category;
  PublicPrompt(super.name, super.content, this.category, super.isFavorite, {this.description = ''});
}
