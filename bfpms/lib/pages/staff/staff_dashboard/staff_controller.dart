import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bfpms/api/auth_repository.dart';
import 'package:bfpms/providers/repository.dart';

import '../../../providers/admin_provider.dart';

final adminProviderNotifier = ChangeNotifierProvider<AdminProvider>((ref) {
  return AdminProvider();
});
final staffControllerProvider =
    StateNotifierProvider<StaffController, StaffState>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      final adminProvider = ref.read(adminProviderNotifier);
      return StaffController(
        authRepository: authRepository,
        adminProvider: adminProvider,
      );
    });

class StaffState {
  final bool isLoading;
  final Map<String, String?> errors;
  final Map<String, dynamic> mapData;

  StaffState({
    this.isLoading = false,
    this.errors = const {},
    this.mapData = const {},
  });

  StaffState copyWith({
    bool? isLoading,
    Map<String, String?>? errors,
    Map<String, String?>? mapData,
  }) {
    return StaffState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }
}

class StaffController extends StateNotifier<StaffState> {
  final AuthRepository authRepository;
  final AdminProvider adminProvider;

  StaffController({required this.authRepository, required this.adminProvider})
    : super(StaffState());

  TextEditingController mobileNoCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  void dispose() {
    mobileNoCon.dispose();
    passCon.dispose();
    super.dispose();
  }
}
