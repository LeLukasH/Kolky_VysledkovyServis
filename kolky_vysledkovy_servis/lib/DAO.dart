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
    var seasons = await db.getSeasons();
    if (seasons.isNotEmpty &&
        seasons
            .reduce((a, b) => a.name.compareTo(b.name) >= 0 ? a : b)
            .dateTo
            .isAfter(DateTime.now())) {
      return seasons;
    }
    seasons = await _api.getSeasons();
    await db.insertSeasons(seasons);
    return seasons;
  }

  Future<List<Country>> getCountries() async {
    return await _api.getCountries();
  }

  Future<List<League>> getLeagues(int seasonId) async {
    var leagues = await db.getLeagues(seasonId);
    if (leagues.isNotEmpty) {
      return leagues;
    }
    leagues = await _api.getLeagues(seasonId);
    await db.insertLeagues(leagues);
    return leagues;
  }

  Future<List<Match>> getMatches(int leagueId, int round) async {
    var matches = await db.getMatches(leagueId, round);
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
    matches = await _api.getMatches(leagueId, round);
    await db.insertMatches(matches);
    return matches;
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    return await _api.getMatchesByDate(date);
  }

  Future<MatchDetail> getMatchDetail(int id) async {
    var matchDetail = await db.getMatchDetail(id);
    if (matchDetail != null) {
      return matchDetail;
    }
    matchDetail = await _api.getMatchDetail(id);
    await db.insertMatchDetail(matchDetail);
    return matchDetail;
  }

  Future<LeagueDetail> getLeagueDetail(int id) async {
    var leagueDetail = await db.getLeagueDetail(id);
    if (leagueDetail != null) {
      return leagueDetail;
    }
    leagueDetail = await _api.getLeagueDetail(id);
    await db.insertLeagueDetail(leagueDetail);
    return leagueDetail;
  }

  Future<TableOfRound> getTable(int leagueId, int round, String type) async {
    return await _api.getTable(leagueId, round, type);
  }

  Future<List<BestResult>> getBestResults(
      int leagueId, int round, String type, String tableType) async {
    return await _api.getBestResults(leagueId, round, type, tableType);
  }

  Future<IndividualResults> getInidividualResults(
      int leagueId, int round) async {
    return await _api.getInidividualResults(leagueId, round);
  }

  Future<Comment> getComment(int leagueId, int round) async {
    return await _api.getComment(leagueId, round);
  }

  Future<List<Tournament>> getTournaments(int seasonId) async {
    return await _api.getTournaments(seasonId);
  }

  Future<TournamentDetail> getTournamentDetail(int id) async {
    return await _api.getTournamentDetail(id);
  }

  Future<PlayerDetail> getPlayerDetail(int id) async {
    return await _api.getPlayerDetail(id);
  }

  Future<PlayerResults> getPlayerResults(int playerId, int seasonId) async {
    return await _api.getPlayerResults(playerId, seasonId);
  }

  Future<Team> getTeam(int teamId) async {
    return await _api.getTeam(teamId);
  }

  Future<List<TeamResult>> getTeamResults(int teamId) async {
    return await _api.getTeamResults(teamId);
  }
}
