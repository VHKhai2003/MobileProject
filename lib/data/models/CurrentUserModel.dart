class CurrentUserModel {
  final String id;
  final String email;
  final String username;

  CurrentUserModel({required this.id, required this.email, required this.username});

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }
}
