import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  final String _baseUrl = 'https://old.kolky.sk';
  final headers = {
    'X-App-AccessToken': 'SK-81aqy12a-a251-1827-b3f8-8336adf6wq99',
    'Content-Type': 'application/json',
  };

  Future<http.Response> send(String path, {dynamic body}) async {
    var jsonBody = json.encode(body);
    var url = '$_baseUrl/$path';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }
}
