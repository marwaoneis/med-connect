import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final Map<String, String> headers;

  ApiService({required this.baseUrl, required this.headers});

  Future<dynamic> fetchData(String endpoint) async {
    var url = Uri.parse('$baseUrl/$endpoint');

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data from $endpoint');
      }
    } catch (e) {
      print('Caught an exception: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
