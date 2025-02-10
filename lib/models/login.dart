class User {
  String username;
  String password;

  User({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
    };
  }
}