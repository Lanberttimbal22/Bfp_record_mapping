import 'package:bfpms/providers/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bfpms/api/auth_repository.dart';

import '../../../providers/admin_provider.dart';

final adminProviderNotifier = ChangeNotifierProvider<AdminProvider>((ref) {
  return AdminProvider();
});
final adminEstablishmentControllerProvider =
    StateNotifierProvider<
      AdminEstablishmentController,
      AdminEstablishmentState
    >((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      final adminProvider = ref.read(adminProviderNotifier);
      return AdminEstablishmentController(
        authRepository: authRepository,
        adminProvider: adminProvider,
      );
    });

class AdminEstablishmentState {
  final bool isLoading;
  final Map<String, String?> errors;
  final Map<String, dynamic> mapData;

  AdminEstablishmentState({
    this.isLoading = false,
    this.errors = const {},
    this.mapData = const {},
  });

  AdminEstablishmentState copyWith({
    bool? isLoading,
    Map<String, String?>? errors,
    Map<String, String?>? mapData,
  }) {
    return AdminEstablishmentState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }
}

class AdminEstablishmentController
    extends StateNotifier<AdminEstablishmentState> {
  final AuthRepository authRepository;
  final AdminProvider adminProvider;

  AdminEstablishmentController({
    required this.authRepository,
    required this.adminProvider,
  }) : super(AdminEstablishmentState()) {
    // Optionally call the function here
    initialize();
  }

  String potcna = "";
  List AdminEstablishmentList = [];
  void initialize() {
    fetchData();
  }

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    final data = await AuthRepository().getData("allUsers");

    if (data is List) {
      AdminEstablishmentList.clear();
      AdminEstablishmentList = data;
      state = state.copyWith();
    } else {
      if (kDebugMode) {
        print("Unexpected response format: $data");
      }
    }
    state = state.copyWith(isLoading: false);
  }
}
