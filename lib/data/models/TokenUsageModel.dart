class TokenUsageModel {
  final int availableTokens;
  final int totalTokens;
  final bool unlimited;
  final String date;

  TokenUsageModel({required this.availableTokens, required this.totalTokens, required this.unlimited, required this.date});

  factory TokenUsageModel.fromJson(Map<String, dynamic> json) {
    return TokenUsageModel(
      availableTokens: json['availableTokens'],
      totalTokens: json['totalTokens'],
      unlimited: json['unlimited'],
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'availableTokens': availableTokens,
      'totalTokens': totalTokens,
      'unlimited': unlimited,
      'date': date
    };
  }
}
