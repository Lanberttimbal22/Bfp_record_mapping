import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bfpms/custom/custom_button.dart';
import 'package:bfpms/custom/custom_textfield.dart';
import 'package:bfpms/custom/route.dart';
import 'package:bfpms/pages/admin/a_staff_form_reg/a_staff_reg_screen.dart';

import 'login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state of your controller (LoginState)
    final loginState = ref.watch(loginControllerProvider);

    // Read your controller to call methods (like login)
    final loginController = ref.read(loginControllerProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  labelText: "Mobile No",
                  controller: loginController.mobileNoCon,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: "Password",
                  controller: loginController.passCon,
                ),
                SizedBox(height: 30),
                CustomActiveButton(
                  bodyText: "Login",
                  onTap: () => loginController.login(context),
                ),
              ],
            ),
          ),

          if (loginState.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black54, // semi-transparent full screen overlay
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
