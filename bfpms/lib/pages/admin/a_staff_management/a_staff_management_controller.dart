import 'package:bfpms/providers/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bfpms/api/auth_repository.dart';

import '../../../providers/admin_provider.dart';

final adminProviderNotifier = ChangeNotifierProvider<AdminProvider>((ref) {
  return AdminProvider();
});
final staffAssignmentControllerProvider =
    StateNotifierProvider<StaffAssignmentController, StaffAssignmentState>((
      ref,
    ) {
      final authRepository = ref.read(authRepositoryProvider);
      final adminProvider = ref.read(adminProviderNotifier);
      return StaffAssignmentController(
        authRepository: authRepository,
        adminProvider: adminProvider,
      );
    });

class StaffAssignmentState {
  final bool isLoading;
  final Map<String, String?> errors;
  final Map<String, dynamic> mapData;

  StaffAssignmentState({
    this.isLoading = false,
    this.errors = const {},
    this.mapData = const {},
  });

  StaffAssignmentState copyWith({
    bool? isLoading,
    Map<String, String?>? errors,
    Map<String, String?>? mapData,
  }) {
    return StaffAssignmentState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }
}

class StaffAssignmentController extends StateNotifier<StaffAssignmentState> {
  final AuthRepository authRepository;
  final AdminProvider adminProvider;

  StaffAssignmentController({
    required this.authRepository,
    required this.adminProvider,
  }) : super(StaffAssignmentState()) {
    // Optionally call the function here
    initialize();
  }

  String potcna = "";
  List staffList = [];
  void initialize() {
    print("initialize");
    fetchData();
  }

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final data = await AuthRepository().getData("allUsers");

    if (data is List) {
      staffList.clear();
      staffList = data;
      state = state.copyWith();
    } else {
      if (kDebugMode) {
        print("Unexpected response format: $data");
      }
    }
    state = state.copyWith(isLoading: false);
  }
}
