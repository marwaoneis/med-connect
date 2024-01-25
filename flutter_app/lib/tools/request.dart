import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/request_config.dart';

Future sendRequest({
  required String route,
  method = "GET",
  load,
  context,
  String? jwtToken,
  String? apiKey,
}) async {
  final url = Uri.http(RequestConfig.url, route);
  final Map<String, String> headers = RequestConfig.getHeaders(context);

  if (jwtToken != null) {
    headers['Authorization'] = 'Bearer $jwtToken';
  }

  if (apiKey != null) {
    headers['X-API-Key'] = apiKey;
  }

  if (method == "GET") {
    final response = await http.get(
      url,
      headers: headers,
    );
    final data = json.decode(response.body);
    return data;
  }

  if (method == "POST") {
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(load),
    );
    final data = json.decode(response.body);
    return data;
  }

  if (method == "PUT") {
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(load),
    );
    final data = json.decode(response.body);
    return data;
  }

  if (method == "DELETE") {
    final response = await http.delete(
      url,
      headers: headers,
    );

    if (response.body.isNotEmpty &&
        response.headers['content-type']?.contains('application/json') ==
            true) {
      final data = json.decode(response.body);
      return data;
    } else if (response.statusCode == 204) {
      return {'success': true};
    } else {
      return {
        'success': false,
        'message':
            'No content in response and status code is ${response.statusCode}'
      };
    }
  }

  return Future(() {
    return "Not a valid method";
  });
}
