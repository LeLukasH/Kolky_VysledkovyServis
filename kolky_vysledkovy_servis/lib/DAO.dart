import 'dart:convert';
import 'API.dart';
import 'all_models.dart';

class DAO {
  final API _api = API();

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
    var body = {
      'seasonId': seasonId,
      "fields": ["category"]
    };
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

  Future<List<Match>> getMatches(List<int> leagueIds, int round) async {
    var body = {
      "leagueIds": leagueIds,
      "round": round,
    };
    var response = await _api.send('match/list', body: body);
    if (response.statusCode == 200) {
      var matchesJson = json.decode(response.body)['list'] as List;
      return matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
    } else {
      throw Exception('Failed to get matches');
    }
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    var body = {
      "dateFrom": date.toString().substring(0, 10),
      "dateTo": date.add(const Duration(days: 1)).toString().substring(0, 10),
    };
    var response = await _api.send('match/list', body: body);
    if (response.statusCode == 200) {
      var matchesJson = json.decode(response.body)['list'] as List;
      return matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
    } else {
      throw Exception('Failed to get matches');
    }
  }

  Future<MatchDetail> getMatchDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('match/detail', body: body);
    if (response.statusCode == 200) {
      return MatchDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get match detail');
    }
  }

  Future<LeagueDetail> getLeagueDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('league/detail', body: body);
    if (response.statusCode == 200) {
      return LeagueDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get league detail');
    }
  }

  Future<TableOfRound> getTable(
      List<String> fields, int leagueId, int round, String type) async {
    var body = {
      "fields": fields,
      "leagueId": leagueId,
      "round": round,
      "type": type
    };
    var response = await _api.send('league/table', body: body);
    if (response.statusCode == 200) {
      try {
        return TableOfRound.fromJson(json.decode(response.body));
      } catch (e) {
        return TableOfRound(tableOfRoundRows: [], extraPoints: []);
      }
    } else {
      throw Exception('Failed to get table');
    }
  }

  Future<Comment> getComment(
      List<String> fields, int leagueId, int round) async {
    var body = {"fields": fields, "leagueId": leagueId, "round": round};
    var response = await _api.send('overview/detail', body: body);
    if (response.statusCode == 200) {
      try {
        return Comment.fromJson(json.decode(response.body));
      } catch (e) {
        return Comment(
            id: 0,
            created: DateTime.now(),
            modified: null,
            content: "",
            leagueId: leagueId,
            round: round,
            createdBy: null);
      }
    } else {
      throw Exception('Failed to get comment');
    }
  }

  Future<List<Tournament>> getTournaments(
      List<String> fields, int seasonId) async {
    var body = {
      "fields": fields,
      "seasonId": seasonId,
    };
    var response = await _api.send('tournament/list', body: body);
    if (response.statusCode == 200) {
      var tournamentsJson = json.decode(response.body)['list'] as List;
      return tournamentsJson
          .map((tournamentJson) => Tournament.fromJson(tournamentJson))
          .toList();
    } else {
      throw Exception('Failed to get tournaments');
    }
  }

  Future<TournamentDetail> getTournamentDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('tournament/detail', body: body);
    if (response.statusCode == 200) {
      return TournamentDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get tournament detail');
    }
  }
}
