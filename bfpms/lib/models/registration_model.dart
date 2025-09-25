class RegistrationModel {
  RegistrationModel({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String role;
  final DateTime createdAt;

  factory RegistrationModel.fromjson(Map<String, dynamic> json) {
    
    return RegistrationModel(
      id: json["id"],
      firstName: json["first_name"].toString(),
      middleName: json["middle_name"].toString(),
      lastName: json["last_name"].toString(),
      email: json["email"] ?? "",
      role: json["role"] ?? "",
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
