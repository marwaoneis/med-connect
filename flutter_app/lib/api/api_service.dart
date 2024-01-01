import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> fetchData(String endpoint) async {
    var url = Uri.parse('$baseUrl/$endpoint');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from $endpoint');
    }
  }
}
