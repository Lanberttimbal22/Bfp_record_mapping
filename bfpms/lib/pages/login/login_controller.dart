import 'dart:convert';

import 'package:bfpms/pages/landing/landing_screen.dart';
import 'package:bfpms/pages/staff/staff_dashboard/staff_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bfpms/api/auth_repository.dart';
import 'package:bfpms/custom/route.dart';
import 'package:bfpms/preferences/user_pref.dart';
import 'package:bfpms/providers/repository.dart';

import '../../providers/admin_provider.dart';

final adminProviderNotifier = ChangeNotifierProvider<AdminProvider>((ref) {
  return AdminProvider();
});
final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      final adminProvider = ref.read(adminProviderNotifier);
      return LoginController(
        authRepository: authRepository,
        adminProvider: adminProvider,
      );
    });

class LoginState {
  final bool isLoading;
  final Map<String, String?> errors;
  final Map<String, dynamic> mapData;

  LoginState({
    this.isLoading = false,
    this.errors = const {},
    this.mapData = const {},
  });

  LoginState copyWith({
    bool? isLoading,
    Map<String, String?>? errors,
    Map<String, String?>? mapData,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final AuthRepository authRepository;
  final AdminProvider adminProvider;

  LoginController({required this.authRepository, required this.adminProvider})
    : super(LoginState());

  TextEditingController mobileNoCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();

    state = state.copyWith(isLoading: true);

    try {
      final formData = {
        "contact_no": mobileNoCon.text,
        "password": passCon.text,
      };
      final response = await authRepository.postData("login", formData);
      print("response $response");

      if (response["status"] == "error") {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(response["msg"])),
        );
        state = state.copyWith(isLoading: false, errors: {});
        return;
      }
      UserPref().storeUserPref(jsonEncode(response["data"]));
      state = state.copyWith(isLoading: false, errors: {});
      SmoothRoute(
        // ignore: use_build_context_synchronously
        context: context,
        child: response["data"]["role_id"] == 1
            ? LandingScreen()
            : StaffScreen(),
      ).route();
    } catch (e) {
      state = state.copyWith(isLoading: false, errors: {"error": e.toString()});
    }
  }

  @override
  void dispose() {
    mobileNoCon.dispose();
    passCon.dispose();
    super.dispose();
  }
}
