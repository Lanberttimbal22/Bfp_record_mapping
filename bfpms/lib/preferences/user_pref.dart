import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  Future<void> destroyPref(String key) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("key");
  }

  Future<void> storeUserPref(String jsonData) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("userData");
    pref.setString("userData", jsonData);
  }

  Future<dynamic> retrieveUserPref() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("userData");

    return jsonDecode(data ?? "{}");
  }
}
