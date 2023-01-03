import 'dart:convert';
import 'API.dart';
import 'models/all_models.dart';

class DAO {
  final API _api;

  DAO(this._api);

  Future<List<Season>> getSeasons() async {
    var response = await _api.send('season/list');
    if (response.statusCode == 200) {
      var seasonsJson = json.decode(response.body)['list'] as List;
      return seasonsJson
          .map((seasonJson) => Season.fromJson(seasonJson))
          .toList();
    } else {
      throw Exception('Failed to get seasons');
    }
  }

  Future<List<Country>> getCountries() async {
    var response = await _api.send('countries');
    if (response.statusCode == 200) {
      var countriesJson = json.decode(response.body)['list'] as List;
      return countriesJson
          .map((countryJson) => Country.fromJson(countryJson))
          .toList();
    } else {
      throw Exception('Failed to get countries');
    }
  }

  Future<List<League>> getLeagues(int seasonId) async {
    var body = {'seasonId': '$seasonId'};
    var response = await _api.send('league/list', body: body);
    if (response.statusCode == 200) {
      var leaguesJson = json.decode(response.body)['list'] as List;
      return leaguesJson
          .map((leagueJson) => League.fromJson(leagueJson))
          .toList();
    } else {
      throw Exception('Failed to get leagues');
    }
  }

  Future<List<Match>> getMatches(
      List<int> leagueIds, String dateFrom, String dateTo) async {
    //var body = {'leagueIds': leagueIds, 'dateFrom': dateFrom, 'dateTo': dateTo};
    var body = {
      "leagueIds": [309],
      "dateFrom": "2023-01-02",
      "dateTo": "2023-02-03"
    };
    var response = await _api.send('match/list', body: body);
    if (response.statusCode == 200) {
      var matchesJson = json.decode(response.body)['list'] as List;
      return matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
    } else {
      throw Exception('Failed to get matches');
    }
  }
}
