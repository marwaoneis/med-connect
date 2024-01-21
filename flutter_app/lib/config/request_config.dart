import 'package:flutter_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RequestConfig {
  static const url = '10.0.2.2:3001';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  static Map<String, String> getHeaders(context) {
    final token = Provider.of<Auth>(context, listen: false).getToken();
    print("token is " + token!);
    if (token != null) {
      return {...headers, 'Authorization': 'Bearer $token'};
    } else {
      return headers;
    }
  }
}
