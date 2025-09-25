import 'package:bfpms/models/staff_models.dart';
import 'package:bfpms/providers/admin_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bfpms/api/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Main admin provider
final adminProviderNotifier = Provider<AdminProvider>((ref) {
  return AdminProvider();
});

// Polling staff list every 5 seconds
final staffListStreamProvider = StreamProvider.autoDispose<List<Staff>>((
  ref,
) async* {
  final adminProvider = ref.read(adminProviderNotifier);

  while (true) {
    await adminProvider.fetchStaffList();
    yield adminProvider.staffList;
    await Future.delayed(const Duration(seconds: 5));
  }
});
