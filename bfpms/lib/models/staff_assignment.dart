class StaffAssignment {
  final String id;
  final String staffId;
  final String establishmentId;
  DateTime assignmentDate;
  String role;

  StaffAssignment({
    required this.id,
    required this.staffId,
    required this.establishmentId,
    required this.assignmentDate,
    required this.role,
  });

  StaffAssignment.create({
    required this.staffId,
    required this.establishmentId,
    required this.role,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       assignmentDate = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'staffId': staffId,
      'establishmentId': establishmentId,
      'assignmentDate': assignmentDate.toIso8601String(),
      'role': role,
    };
  }

  factory StaffAssignment.fromMap(Map<String, dynamic> map) {
    return StaffAssignment(
      id: map['id'],
      staffId: map['staffId'],
      establishmentId: map['establishmentId'],
      assignmentDate: DateTime.parse(map['assignmentDate']),
      role: map['role'],
    );
  }
}
