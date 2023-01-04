import 'dart:convert';

import 'package:http/http.dart' as http;

/*
void main(List<String> args) async {
  var headers = {
    'X-App-AccessToken': 'SK-81aqy12a-a251-1827-b3f8-8336adf6wq99',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  var body =
      "{\"leagueIds\": [308],\"dateFrom\": \"2023-01-02\",\"dateTo\": \"2023-02-03\"}";
  print(body);
  var response = await http.post(Uri.parse('https://old.kolky.sk/match/list'),
      headers: headers, body: body);

var request = http.Request('POST', Uri.parse('https://old.kolky.sk/match/list'));
		request.body = json.encode({
		  "leagueIds": [
		    308
		  ],
		  "dateFrom": "2023-01-02",
		  "dateTo": "2023-02-03"
		});
  if (response.statusCode == 200) {
    print(response.body.length);
  } else {
    print(response.reasonPhrase);
  }
}
*/
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'X-App-AccessToken': 'SK-81aqy12a-a251-1827-b3f8-8336adf6wq99',
    'Content-Type': 'application/json',
  };
  var request =
      http.Request('POST', Uri.parse('https://old.kolky.sk/match/list'));
  request.body = json.encode({
    "leagueIds": [308],
    "dateFrom": "2023-01-02",
    "dateTo": "2023-02-03"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
