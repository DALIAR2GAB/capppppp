class SignUpModel {
  String email;
  String gender;
  String fullName;
  String password;
  String confirmPassword;
  String username;
  String userType;
  int Age;

  SignUpModel({
    required this.Age,
    required this.email,
    required this.gender,
    required this.fullName,
    required this.password,
    required this.confirmPassword,
    required this.username,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "Age":Age,
      "Email": email,
      "Gender": gender,
      "FullName": fullName,
      "Password": password,
      "ConfirmPassword": confirmPassword,
      "Username": username,
      "UserType": userType,
    };
  }
}