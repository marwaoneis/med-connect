import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/request_config.dart';

Future sendRequest({
  required String route,
  method = "GET",
  load,
  context,
}) async {
  final url = Uri.http(RequestConfig.url, route);
  final Map<String, String> headers = RequestConfig.getHeaders(context);

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
    final data = json.decode(response.body);
    print(response.body);
    return data;
  }

  return Future(() {
    return "Not a valid method";
  });
}
