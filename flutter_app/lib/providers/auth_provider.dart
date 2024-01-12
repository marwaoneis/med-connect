import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/request_config.dart';
// import '../models/exception_model.dart';
import '../data/sign_up_form_data.dart';

enum UserType { patient, doctor, pharmacy }

class Auth with ChangeNotifier {
  String? userId;
  String? token;

  String? get getUserId {
    if (userId != null) {
      return userId;
    }

    return null;
  }

  String? get getToken {
    if (token != null) {
      return token;
    }

    return null;
  }

  Future<void> login(
      String username, String password, UserType userType) async {
    String url;
    switch (userType) {
      case UserType.patient:
        url = 'http://10.0.2.2:3001/patient/auth/login';
        break;
      case UserType.doctor:
        url = 'http://10.0.2.2:3001/doctor/auth/login';
        break;
      case UserType.pharmacy:
        url = 'http://10.0.2.2:3001/pharmacy/auth/login';
        break;
    }

    final response = await http.post(
      Uri.parse(url),
      headers: RequestConfig.headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Here is the data: $responseData");
      _saveUserData(responseData);
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> signUp(SignUpFormData formData) async {
    const url = 'http://10.0.2.2:3001/patient/auth/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: RequestConfig.headers,
        body: json.encode(formData.toJson()),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _saveUserData(responseData);
      } else {
        throw Exception(responseData['error'] ?? 'Failed to sign up');
      }
    } on http.ClientException catch (error) {
      throw Exception('Network error: ${error.message}');
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userId = null;
    token = null;
    notifyListeners();
  }

  Future<void> _saveUserData(dynamic responseData) async {
    final prefs = await SharedPreferences.getInstance();
    userId = responseData['id'];
    token = responseData['token'];

    if (userId != null && token != null) {
      await prefs.setString('id', userId!);
      await prefs.setString('token', token!);
    } else {
      print("Error: User ID or Token is null.");
    }

    print("User ID in _saveUserData: $userId");
    print("User token in _saveUserData: $token");
    notifyListeners();
  }
}
