import 'dart:convert';
import 'package:kolky_vysledkovy_servis/models/player_results.dart';
import 'package:kolky_vysledkovy_servis/models/status.dart';

import 'api.dart';
import 'models/best_result.dart';
import 'models/comment.dart';
import 'models/country.dart';
import 'models/individual_result.dart';
import 'models/league.dart';
import 'models/league_detail.dart';
import 'models/match_detail.dart';
import 'models/player_detail.dart';
import 'models/season.dart';
import 'models/match.dart';
import 'models/table_of_round.dart';
import 'models/team.dart';
import 'models/team_result.dart';
import 'models/tournament.dart';
import 'models/tournament_detail.dart';

import 'database.dart';

class DAO {
  final API _api = API();

  final db = KolkyDatabase.instance;

  Future<List<Season>> getSeasons() async {
    var seasons = await db.dbGetSeasons();
    if (seasons.isNotEmpty &&
        seasons
            .reduce((a, b) => a.name.compareTo(b.name) >= 0 ? a : b)
            .dateTo
            .isAfter(DateTime.now())) {
      return seasons;
    }
    var response = await _api.send('season/list');
    seasons = seasonsFromJson(response.body).list;
    await db.dbInsertSeasons(seasons);
    return seasons;
  }

  Future<List<Country>> getCountries() async {
    var response = await _api.send('countries');
    return countriesFromJson(response.body).list;
  }

  Future<List<League>> getLeagues(int seasonId) async {
    var leagues = await db.dbGetLeagues(seasonId);
    if (leagues.isNotEmpty) {
      return leagues;
    }
    var body = {
      'seasonId': seasonId,
      "fields": ["category"]
    };
    var response = await _api.send('league/list', body: body);
    leagues = leaguesFromJson(response.body).list;
    await db.dbInsertLeagues(leagues);
    return leagues;
  }

  Future<List<Match>> getMatches(int leagueId, int round) async {
    var matches = await db.dbGetMatches(leagueId, round);
    bool actual = true;
    for (Match match in matches) {
      if (match.startDate.isBefore(DateTime.now()) &&
          match.status != Status.FINISHED) {
        actual = false;
        break;
      }
    }
    if (matches.isNotEmpty && actual) {
      return matches;
    }
    var body = {
      "leagueIds": [leagueId],
      "round": round,
    };
    var response = await _api.send('match/list', body: body);
    matches = matchesFromJson(response.body).list;
    await db.dbInsertMatches(matches);
    return matches;
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    var body = {
      "dateFrom": date.toString().substring(0, 10),
      "dateTo": date.add(const Duration(days: 1)).toString().substring(0, 10),
    };
    var response = await _api.send('match/list', body: body);
    return matchesFromJson(response.body).list;
  }

  Future<MatchDetail> getMatchDetail(int id, List<String> fields) async {
    var matchDetail = await db.dbGetMatchDetail(id);
    if (matchDetail != null) {
      return matchDetail;
    }
    var body = {"id": id, "fields": fields};
    var response = await _api.send('match/detail', body: body);
    matchDetail = matchDetailFromJson(response.body);
    await db.dbInsertMatchDetail(matchDetail);
    return matchDetail;
  }

  Future<LeagueDetail> getLeagueDetail(int id, List<String> fields) async {
    var leagueDetail = await db.dbGetLeagueDetail(id);
    if (leagueDetail != null) {
      return leagueDetail;
    }
    var body = {"id": id, "fields": fields};
    var response = await _api.send('league/detail', body: body);
    leagueDetail = leagueDetailFromJson(response.body);
    await db.dbInsertLeagueDetail(leagueDetail);
    return leagueDetail;
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
      return tableOfRoundFromJson(response.body);
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
    return bestResultFromJson(response.body);
  }

  Future<IndividualResults> getInidividualResults(
      int leagueId, int round) async {
    var body = {
      "leagueId": leagueId,
      "round": round,
    };
    var response = await _api.send('league/averages', body: body);
    return individualResultsFromJson(response.body);
  }

  Future<Comment> getComment(
      List<String> fields, int leagueId, int round) async {
    var body = {"fields": fields, "leagueId": leagueId, "round": round};
    var response = await _api.send('overview/detail', body: body);
    try {
      return commentFromJson(response.body);
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
    return tournamentsFromJson(response.body).list;
  }

  Future<TournamentDetail> getTournamentDetail(
      int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('tournament/detail', body: body);
    return tournamentDetailFromJson(response.body);
  }

  Future<PlayerDetail> getPlayerDetail(int id, List<String> fields) async {
    var body = {"id": id, "fields": fields};
    var response = await _api.send('player/statistics', body: body);
    return playerDetailFromJson(response.body);
  }

  Future<PlayerResults> getPlayerResults(
      int playerId, int seasonId, List<String> fields) async {
    var body = {"id": playerId, "seasonId": seasonId, "fields": fields};
    var response = await _api.send('player/results', body: body);
    return playerResultsFromJson(response.body);
  }

  Future<Team> getTeam(int teamId) async {
    var body = {"id": teamId};
    var response = await _api.send('team/detail', body: body);
    return Team.fromJson(json.decode(response.body));
  }

  Future<List<TeamResult>> getTeamResults(int teamId) async {
    var body = {"id": teamId};
    var response = await _api.send('team/results', body: body);
    var resultsJson = json.decode(response.body)['list'] as List;
    return resultsJson
        .map((resultJson) => TeamResult.fromJson(resultJson))
        .toList();
  }
}
