import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/sign_up_form_data.dart';
import '../config/request_config.dart';

enum UserType { patient, doctor, pharmacy }

class Auth with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;

  String? get token => _token;

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
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _token = responseData['token'];
      await _storage.write(key: 'token', value: _token);
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(SignUpFormData formData) async {
    const url = RequestConfig.url +
        '/patient/auth/register'; // Update the URL as needed

    final response = await http.post(
      Uri.parse(url),
      headers: RequestConfig.headers,
      body: json.encode({
        'firstName': formData.firstName,
        'lastName': formData.lastName,
        // ... (rest of the formData fields)
      }),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      _token = responseData['token'];
      await _storage.write(key: 'token', value: _token);
      notifyListeners();
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    _token = null;
    notifyListeners();
  }
}
