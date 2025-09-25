import 'package:bfpms/api/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final staffFormRegistrationProvider = ChangeNotifierProvider<AuthRepository>((
  ref,
) {
  return AuthRepository();
});

class StaffFormRegistrationState {
  final bool isLoading;
  final bool isShowFirst;
  final Map<String, String?> errors;

  StaffFormRegistrationState({
    this.isLoading = false,
    this.isShowFirst = true,
    this.errors = const {},
  });

  StaffFormRegistrationState copyWith({
    bool? isLoading,
    bool? isShowFirst,
    Map<String, String?>? errors,
  }) {
    return StaffFormRegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isShowFirst: isShowFirst ?? this.isShowFirst,
      errors: errors ?? this.errors,
    );
  }
}

class StaffFormRegistrationController
    extends StateNotifier<StaffFormRegistrationState> {
  StaffFormRegistrationController() : super(StaffFormRegistrationState()) {
    initializeApp();
  }

  //Variables
  final formKey = GlobalKey<FormState>();
  final loadingBtn = StateProvider<bool>((ref) => false);

  String? statusId;
  String? genderId;
  String? roleId;
  String image = "";
  TextEditingController fullName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  List<Map<String, dynamic>> genderData = [];

  //Functions
  void initializeApp() {}

  void clearForm() {
    fullName.clear();
    birthday.clear();
    contactNo.clear();
    address.clear();
    password.clear();
    state = state.copyWith(errors: {});
  }

  TextInputType getKeyType(String type) {
    switch (type) {
      case 'number':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  void changeScreen(bool isBack, BuildContext context) {
    if (!state.isShowFirst && isBack) {
      state = state.copyWith(isShowFirst: !state.isShowFirst);
      return;
    }
    if (state.isShowFirst && isBack) {
      clearForm();
      Navigator.of(context).pop();
    }
    state = state.copyWith(isShowFirst: !state.isShowFirst);
  }

  void onSave(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      Map<String, String> formData = {
        "full_name": fullName.text,
        "birthday": birthday.text,
        "gender_id": genderId.toString(),
        "image": "profile123.jpg",
        "contact_no": contactNo.text,
        "address": address.text,
        "password": password.text,
        "role_id": roleId.toString(),
        "status_id": 1.toString(),
      };

      state = state.copyWith(isLoading: true);

      await Future.delayed(Duration(seconds: 1));

      final success = await ref
          .read(staffFormRegistrationProvider)
          .postData("register", formData);

      state = state.copyWith(isLoading: false);

      if (success["status"] == "Success") {
        clearForm();
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Successfully added')));
          state = state.copyWith(isLoading: true);
          await Future.delayed(Duration(seconds: 2));
          state = state.copyWith(isLoading: false);
          // ignore: use_build_context_synchronously
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('StaffFormRegistration failed')));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fix the errors in red')));
    }
  }
}
