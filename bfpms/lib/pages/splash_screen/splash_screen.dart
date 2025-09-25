import 'package:bfpms/pages/admin/a_staff_management/a_staff_management.dart';
import 'package:bfpms/pages/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bfpms/custom/custom_text.dart';
import 'package:bfpms/custom/route.dart';
import 'package:bfpms/pages/login/login_screen.dart';

import '../../preferences/user_pref.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    await UserPref().destroyPref("userData");
    final localContext = context; // ✅ Capture context before `await`

    userData = await UserPref().retrieveUserPref();
    // print("userData $userData");

    await Future.delayed(Duration(seconds: 1));

    if (!mounted) return; // ✅ Check if widget is still in the tree

    // ignore: use_build_context_synchronously
    SmoothRoute(
      context: localContext,
      child: userData.isEmpty
          ? LoginScreen()
          : userData["role_id"] == 1
          ? LandingScreen()
          : StaffManagementScreen(),
    ).route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: AppText("Hi, Welcome to mental hospital "))],
        ),
      ),
    );
  }
}
