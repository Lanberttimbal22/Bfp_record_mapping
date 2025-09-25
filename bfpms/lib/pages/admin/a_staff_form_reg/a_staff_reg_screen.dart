import 'package:bfpms/custom/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:bfpms/custom/custom_textfield.dart';
import 'a_staff_form_reg_controller.dart';

import '../../../custom/custom_button.dart';

final staffFormRegistrationProvider =
    StateNotifierProvider<
      StaffFormRegistrationController,
      StaffFormRegistrationState
    >((ref) {
      return StaffFormRegistrationController();
    });

class StaffFormRegistrationScreen extends ConsumerStatefulWidget {
  const StaffFormRegistrationScreen({super.key});

  @override
  ConsumerState<StaffFormRegistrationScreen> createState() =>
      _StaffFormRegistrationScreenState();
}

class _StaffFormRegistrationScreenState
    extends ConsumerState<StaffFormRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(staffFormRegistrationProvider.notifier).clearForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    final staffFormRegistrationState = ref.watch(staffFormRegistrationProvider);
    final controller = ref.read(staffFormRegistrationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => controller.changeScreen(true, context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      customDropdown(
                        isDisabled: false,
                        labelText: 'Role',
                        items: [
                          {"text": "Admin", "value": 1},
                          {"text": "Staff", "value": 2},
                        ],
                        selectedValue: controller.roleId,
                        onChanged: (value) {
                          controller.roleId = value.toString();
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Full Name",
                        controller: controller.fullName,
                        validator: (e) {
                          if (e == null || e.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Birthday",
                        controller: controller.birthday,
                        validator: (e) {
                          if (e == null || e.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),
                      customDropdown(
                        isDisabled: false,
                        labelText: 'Gender',
                        items: [
                          {"text": "Male", "value": 1},
                          {"text": "Female", "value": 2},
                        ],
                        selectedValue: controller.genderId,
                        onChanged: (value) {
                          controller.genderId = value.toString();
                        },
                      ),
                      SizedBox(height: 10),

                      CustomTextFormField(
                        labelText: "Contact No",
                        controller: controller.contactNo,
                        validator: (e) {
                          if (e == null || e.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Address",
                        controller: controller.address,
                        validator: (e) {
                          if (e == null || e.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Password",
                        controller: controller.password,
                        validator: (e) {
                          if (e == null || e.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30),
                      CustomActiveButton(
                        bodyText: "Submit",
                        onTap: () => controller.onSave(context, ref),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (staffFormRegistrationState.isLoading)
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
