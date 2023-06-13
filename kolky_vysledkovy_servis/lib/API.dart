import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/best_result.dart';
import 'models/comment.dart';
import 'models/country.dart';
import 'models/individual_result.dart';
import 'models/league.dart';
import 'models/league_detail.dart';
import 'models/match.dart';
import 'models/match_detail.dart';
import 'models/player_detail.dart';
import 'models/player_results.dart';
import 'models/season.dart';
import 'models/table_of_round.dart';
import 'models/team.dart';
import 'models/team_result.dart';
import 'models/tournament.dart';
import 'models/tournament_detail.dart';

class API {
  final String _baseUrl = 'https://old.kolky.sk';
  final headers = {
    'X-App-AccessToken': 'SK-81aqy12a-a251-1827-b3f8-8336adf6wq99',
    'Content-Type': 'application/json',
  };

  Future<http.Response> send(String path, {dynamic body}) async {
    final url = '$_baseUrl/$path';
    final request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Api Failed');
    }
  }

  Future<List<Season>> getSeasons() async {
    final response = await send('season/list');
    return seasonsFromJson(response.body).list;
  }

  Future<List<Country>> getCountries() async {
    final response = await send('countries');
    return countriesFromJson(response.body).list;
  }

  Future<List<League>> getLeagues(int seasonId) async {
    final body = {
      'seasonId': seasonId,
      "fields": ["category"]
    };
    final response = await send('league/list', body: body);
    return leaguesFromJson(response.body).list;
  }

  Future<List<Match>> getMatches(int leagueId, int round) async {
    final body = {
      "leagueIds": [leagueId],
      "round": round,
    };
    final response = await send('match/list', body: body);
    return matchesFromJson(response.body).list;
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    final body = {
      "dateFrom": date.toString().substring(0, 10),
      "dateTo": date.add(const Duration(days: 1)).toString().substring(0, 10),
    };
    final response = await send('match/list', body: body);
    return matchesFromJson(response.body).list;
  }

  Future<MatchDetail> getMatchDetail(int id) async {
    final body = {
      "id": id,
      "fields": [
        "league",
        "details",
        "teams",
        "teams.club",
        "results",
        "results.lanes",
        "referee",
        "substitutions",
        "sprint",
        "hall"
      ],
    };
    final response = await send('match/detail', body: body);
    return matchDetailFromJson(response.body);
  }

  Future<LeagueDetail> getLeagueDetail(int id, List<String> fields) async {
    final body = {"id": id, "fields": fields};
    final response = await send('league/detail', body: body);
    return leagueDetailFromJson(response.body);
  }

  Future<TableOfRound> getTable(int leagueId, int round, String type) async {
    final body = {"leagueId": leagueId, "round": round, "type": type};
    final response = await send('league/table', body: body);
    try {
      return tableOfRoundFromJson(response.body);
    } catch (e) {
      return TableOfRound(tableOfRoundRows: [], extraPoints: []);
    }
  }

  Future<List<BestResult>> getBestResults(
      int leagueId, int round, String type, String tableType) async {
    final body = {
      "leagueId": leagueId,
      "round": round,
      "type": type,
      "tableType": tableType
    };
    final response = await send('league/bestResults', body: body);
    return bestResultFromJson(response.body);
  }

  Future<IndividualResults> getInidividualResults(
      int leagueId, int round) async {
    final body = {
      "leagueId": leagueId,
      "round": round,
    };
    final response = await send('league/averages', body: body);
    return individualResultsFromJson(response.body);
  }

  Future<Comment> getComment(int leagueId, int round) async {
    final body = {"leagueId": leagueId, "round": round};
    final response = await send('overview/detail', body: body);
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

  Future<List<Tournament>> getTournaments(int seasonId) async {
    final body = {
      "fields": ["tournamentGroup", "tournamentGroup.parentTournamentGroup"],
      "seasonId": seasonId,
    };
    final response = await send('tournament/list', body: body);
    return tournamentsFromJson(response.body).list;
  }

  Future<TournamentDetail> getTournamentDetail(int id) async {
    var body = {
      "id": id,
      "fields": [
        "club",
        "hall",
        "tournamentRounds",
        "tournamentRounds.hall",
        "tournamentRounds.results",
        "tournamentRounds.results.lanes"
      ]
    };
    var response = await send('tournament/detail', body: body);
    return tournamentDetailFromJson(response.body);
  }

  Future<PlayerDetail> getPlayerDetail(int id) async {
    final body = {
      "id": id,
      "fields": [
        "player.club",
      ]
    };
    final response = await send('player/statistics', body: body);
    return playerDetailFromJson(response.body);
  }

  Future<PlayerResults> getPlayerResults(int playerId, int seasonId) async {
    final body = {
      "id": playerId,
      "seasonId": seasonId,
      "fields": [
        "cards",
        "cards.player",
        "results.match",
        "results.tournament",
        "results.tournamentRound",
        "results.tournamentRound.hall",
        "results.match.hall",
        "results.match.hall.parent",
        "results.match.teams"
      ]
    };
    final response = await send('player/results', body: body);
    return playerResultsFromJson(response.body);
  }

  Future<Team> getTeam(int teamId) async {
    final body = {"id": teamId};
    final response = await send('team/detail', body: body);
    return Team.fromJson(json.decode(response.body));
  }

  Future<List<TeamResult>> getTeamResults(int teamId) async {
    final body = {"id": teamId};
    final response = await send('team/results', body: body);
    final resultsJson = json.decode(response.body)['list'] as List;
    return resultsJson
        .map((resultJson) => TeamResult.fromJson(resultJson))
        .toList();
  }
}
