import 'dart:convert';

import 'package:http/http.dart' as http;

void main(List<String> args) async {
  var headers = {
    'X-App-AccessToken': 'SK-81aqy12a-a251-1827-b3f8-8336adf6wq99',
    'Content-Type': 'application/json',
  };
  var response = await http.post(Uri.parse('https://old.kolky.sk/match/list'),
      headers: headers,
      body: json.encode(
        {
          "leagueIds": [308]
        },
      ));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}
