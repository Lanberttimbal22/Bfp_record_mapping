class Staff {
  final String id;
  String fullName;
  String birthday;
  String genderId;
  String image;
  String contactNo;
  String address;
  String roleId;
  String statusId;

  Staff({
    required this.id,
    required this.fullName,
    required this.birthday,
    required this.genderId,
    required this.image,
    required this.contactNo,
    required this.address,
    required this.roleId,
    required this.statusId,
  });

  // Constructor for creating a new staff with auto-generated ID
  Staff.create({
    required this.fullName,
    required this.birthday,
    required this.genderId,
    required this.image,
    required this.contactNo,
    required this.address,
    required this.roleId,
    required this.statusId,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'birthday': birthday,
      'gender_id': genderId,
      'image': image,
      'contact_no': contactNo,
      'address': address,
      'role_id': roleId,
      'status_id': statusId,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      id: map['id'],
      fullName: map['full_name'],
      birthday: map['birthday'],
      genderId: map['gender_id'],
      image: map['image'],
      contactNo: map['contact_no'],
      address: map['address'],
      roleId: map['role_id'],
      statusId: map['status_id'],
    );
  }
}
