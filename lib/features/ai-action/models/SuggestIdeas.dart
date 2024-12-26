class SuggestIdeas {
  List<String> ideas;

  SuggestIdeas(this.ideas);

  factory SuggestIdeas.fromJson(Map<String, dynamic> json) {
    var ideasList = json['ideas'] as List<dynamic>;
    return SuggestIdeas(
      ideasList.map((idea) => idea.toString()).toList(),
    );
  }
}
