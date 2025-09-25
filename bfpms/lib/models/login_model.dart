class LoginModel {
  LoginModel({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String role;
  final String createdAt;

  factory LoginModel.fromjson(Map<String, dynamic> json) {
    return LoginModel(
      id: json["id"],
      firstName: json["first_name"],
      middleName: json["middle_name"],
      lastName: json["last_name"],
      email: json["email"],
      role: json["role"],
      createdAt: json["created_at"],
    );
  }
}
