class EmailResponse {
  final String email;
  final int remainingUsage;

  EmailResponse({required this.email, required this.remainingUsage});

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      email: json['email'],
      remainingUsage: json['remainingUsage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'remainingUsage': remainingUsage,
    };
  }
}
