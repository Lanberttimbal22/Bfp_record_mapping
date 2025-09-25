class UserModel {
  UserModel({
    required this.id,
    required this.roleId,
    required this.statusId,
    required this.fullName,
    required this.birthday,
    required this.genderId,
    required this.image,
    required this.contactNo,
    required this.address,
    required this.password,
    required this.createdBy,
    required this.createdAt,
  });

  final int id;
  final int roleId;
  final int statusId;
  final int genderId;
  final String fullName;
  final String birthday;
  final String image;
  final String contactNo;
  final String address;
  final String password;

  final DateTime createdBy;
  final DateTime createdAt;

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      roleId: json["role_id"],
      statusId: json["status_id"],
      genderId: json["gender_id"],
      fullName: json["full_name"],
      birthday: json["birthday"],
      image: json["image"].toString(),
      contactNo: json["contact_no"].toString(),
      address: json["address"].toString(),
      password: json["password"] ?? "",
      createdBy: DateTime.parse(json["created_by"]),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
