import 'dart:convert';
import 'api.dart';
import 'all_models.dart';

class DAO {
  final API _api = API();

  Future<List<Season>> getSeasons() async {
    var response = await _api.send('season/list');
    var seasonsJson = json.decode(response.body)['list'] as List;
    return seasonsJson
        .map((seasonJson) => Season.fromJson(seasonJson))
        .toList();
  }

  Future<List<Country>> getCountries() async {
    var response = await _api.send('countries');
    var countriesJson = json.decode(response.body)['list'] as List;
    return countriesJson
        .map((countryJson) => Country.fromJson(countryJson))
        .toList();
  }

  Future<List<League>> getLeagues(int seasonId) async {
    var body = {
      'seasonId': seasonId,
      "fields": ["category"]
    };
    var response = await _api.send('league/list', body: body);
    var leaguesJson = json.decode(response.body)['list'] as List;
    return leaguesJson
        .map((leagueJson) => League.fromJson(leagueJson))
        .toList();
  }

  Future<List<Match>> getMatches(List<int> leagueIds, int round) async {
    var body = {
      "leagueIds": leagueIds,
      "round": round,
    };
    var response = await _api.send('match/list', body: body);
    var matchesJson = json.decode(response.body)['list'] as List;
    return matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    var body = {
      "dateFrom": date.toString().substring(0, 10),
      "dateTo": date.add(const Duration(days: 1)).toString().substring(0, 10),
    };
    var response = await _api.send('match/list', body: body);
    var matchesJson = json.decode(response.body)['list'] as List;
    return matchesJson.map((matchJson) => Match.fromJson(matchJson)).toList();
  }

  Future<MatchDetail> getMatchDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('match/detail', body: body);
    return MatchDetail.fromJson(json.decode(response.body));
  }

  Future<LeagueDetail> getLeagueDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('league/detail', body: body);
    return LeagueDetail.fromJson(json.decode(response.body));
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
    try {
      return TableOfRound.fromJson(json.decode(response.body));
    } catch (e) {
      return TableOfRound(tableOfRoundRows: [], extraPoints: []);
    }
  }

  Future<List<BestResult>> getBestResults(
      int leagueId, int round, String type, String tableType) async {
    var body = {
      "leagueId": leagueId,
      "round": round,
      "type": type,
      "tableType": tableType
    };
    var response = await _api.send('league/bestResults', body: body);
    var bestResultsJson = json.decode(response.body) as List;
    return bestResultsJson
        .map((bestResultJson) => BestResult.fromJson(bestResultJson))
        .toList();
  }

  Future<IndividualResults> getInidividualResults(
      int leagueId, int round) async {
    var body = {
      "leagueId": leagueId,
      "round": round,
    };
    var response = await _api.send('league/averages', body: body);
    return IndividualResults.fromJson(json.decode(response.body));
  }

  Future<Comment> getComment(
      List<String> fields, int leagueId, int round) async {
    var body = {"fields": fields, "leagueId": leagueId, "round": round};
    var response = await _api.send('overview/detail', body: body);
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
  }

  Future<List<Tournament>> getTournaments(
      List<String> fields, int seasonId) async {
    var body = {
      "fields": fields,
      "seasonId": seasonId,
    };
    var response = await _api.send('tournament/list', body: body);
    var tournamentsJson = json.decode(response.body)['list'] as List;
    return tournamentsJson
        .map((tournamentJson) => Tournament.fromJson(tournamentJson))
        .toList();
  }

  Future<TournamentDetail> getTournamentDetail(
      int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('tournament/detail', body: body);
    return TournamentDetail.fromJson(json.decode(response.body));
  }
}
