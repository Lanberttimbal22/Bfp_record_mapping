import 'package:bfpms/api/auth_repository.dart';
import 'package:flutter/foundation.dart';

import '../models/establishment_model.dart';
import '../models/staff_assignment.dart';
import '../models/staff_models.dart';

class AdminProvider with ChangeNotifier {
  final List<Staff> _staffList = [];
  final List<Establishment> _establishments = [];
  final List<StaffAssignment> _assignments = [];

  List<Staff> get staffList => _staffList;
  List<Establishment> get establishments => _establishments;
  List<StaffAssignment> get assignments => _assignments;

  Future<void> fetchStaffList() async {
    final response = await AuthRepository().getData("allUsers");

    if (response is List) {
      _staffList.clear(); // optional: clear previous list
      print("_staffList $_staffList");
      _staffList.addAll(response.map((item) => Staff.fromMap(item)).toList());
      notifyListeners();
    } else {
      print("Unexpected response format: $response");
    }
  }

  void updateStaff(String id, Staff updatedStaff) {
    final index = _staffList.indexWhere((staff) => staff.id == id);
    if (index != -1) {
      _staffList[index] = updatedStaff;
      notifyListeners();
    }
  }

  void deleteStaff(String id) {
    _staffList.removeWhere((staff) => staff.id == id);
    // Remove related assignments
    _assignments.removeWhere((assignment) => assignment.staffId == id);
    notifyListeners();
  }

  // Establishment Management
  void addEstablishment(Establishment establishment) {
    _establishments.add(establishment);
    notifyListeners();
  }

  void updateEstablishment(String id, Establishment updatedEstablishment) {
    final index = _establishments.indexWhere((est) => est.id == id);
    if (index != -1) {
      _establishments[index] = updatedEstablishment;
      notifyListeners();
    }
  }

  void deleteEstablishment(String id) {
    _establishments.removeWhere((est) => est.id == id);
    // Remove related assignments
    _assignments.removeWhere((assignment) => assignment.establishmentId == id);
    notifyListeners();
  }

  // Assignment Management
  void assignStaff(StaffAssignment assignment) {
    _assignments.add(assignment);
    notifyListeners();
  }

  void removeAssignment(String id) {
    _assignments.removeWhere((assignment) => assignment.id == id);
    notifyListeners();
  }

  List<StaffAssignment> getAssignmentsByEstablishment(String establishmentId) {
    return _assignments
        .where((assignment) => assignment.establishmentId == establishmentId)
        .toList();
  }

  List<StaffAssignment> getAssignmentsByStaff(String staffId) {
    return _assignments
        .where((assignment) => assignment.staffId == staffId)
        .toList();
  }

  Staff? getStaffById(String id) {
    return _staffList.firstWhere((staff) => staff.id == id);
  }

  Establishment? getEstablishmentById(String id) {
    return _establishments.firstWhere((est) => est.id == id);
  }
}
