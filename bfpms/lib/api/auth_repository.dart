import 'dart:convert';
import 'package:bfpms/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends ChangeNotifier {
  final String baseUrl;

  AuthRepository({this.baseUrl = "http://$phoneHost:8000/api"});

  Future<Map<String, dynamic>> postData(
    String endPoint,
    Map<String, String> formData,
  ) async {
    Uri url = Uri.parse("$baseUrl/$endPoint");

    try {
      http.MultipartRequest request = http.MultipartRequest("POST", url);

      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      request.headers.addAll({'Accept': 'application/json'});
      http.StreamedResponse response = await request.send();

      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(responseBody);
      } else {
        debugPrint("Failed to login: $responseBody");
        return json.decode(responseBody);
      }
    } catch (e) {
      debugPrint("Error logging in: $e");
      return {};
    }
  }

  Future<dynamic> getData(String endPoint) async {
    try {
      Uri url = Uri.parse("$baseUrl/$endPoint");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        notifyListeners();
        return result;
      } else {
        debugPrint("Failed to load todos. Status: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      debugPrint("Error fetching todos: $e");
      return {};
    }
  }
}
