import 'dart:async';

import 'package:kolky_vysledkovy_servis/models/league_detail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/league.dart';
import 'models/match.dart';
import 'models/match_detail.dart';
import 'models/season.dart';

class KolkyDatabase {
  static final KolkyDatabase instance = KolkyDatabase._init();

  static Database? _database;

  KolkyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('kolky.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(MatchFields.createTableQuery);
    await db.execute(MatchDetailFields.createTableQuery);
    await db.execute(SeasonFields.createTableQuery);
    await db.execute(LeagueFields.createTableQuery);
    await db.execute(LeagueDetailFields.createTableQuery);
  }

  Future<List<Season>> getSeasons() async {
    final db = await instance.database;
    final result =
        await db.query(SeasonFields.tableSeason, columns: SeasonFields.values);
    return result.map((json) => Season.fromJson(json)).toList();
  }

  Future<void> insertSeasons(List<Season> seasons) async {
    final db = await instance.database;
    for (Season season in seasons) {
      if (await db.query(SeasonFields.tableSeason,
          where: '${SeasonFields.id} = ?',
          whereArgs: [season.id]).then((rows) => rows.isEmpty)) {
        await db.insert(SeasonFields.tableSeason, season.toJson());
      } else {
        await db.update(SeasonFields.tableSeason, season.toJson(),
            where: '${SeasonFields.id} = ?', whereArgs: [season.id]);
      }
    }
  }

  Future<List<League>> getLeagues(int seasonId) async {
    final db = await instance.database;
    final result = await db.query(LeagueFields.tableLeague,
        columns: LeagueFields.values,
        where: '${LeagueFields.seasonId} = ?',
        whereArgs: [seasonId]);
    return result.map((json) => League.fromJson(json)).toList();
  }

  Future<void> insertLeagues(List<League> leagues) async {
    final db = await instance.database;
    for (League league in leagues) {
      if (await db.query(LeagueFields.tableLeague,
          where: '${LeagueFields.id} = ?',
          whereArgs: [league.id]).then((rows) => rows.isEmpty)) {
        await db.insert(LeagueFields.tableLeague, league.toJson());
      } else {
        await db.update(LeagueFields.tableLeague, league.toJson(),
            where: '${LeagueFields.id} = ?', whereArgs: [league.id]);
      }
    }
  }

  Future<LeagueDetail?> getLeagueDetail(int id) async {
    final db = await instance.database;
    final result = await db.query(LeagueDetailFields.tableLeagueDetail,
        columns: LeagueDetailFields.values,
        where: '${LeagueDetailFields.id} = ?',
        whereArgs: [id]);
    if (result.isEmpty) return null;
    return result.map((json) => LeagueDetail.fromJson(json)).first;
  }

  Future<void> insertLeagueDetail(LeagueDetail leagueDetail) async {
    final db = await instance.database;
    if (await db.query(LeagueDetailFields.tableLeagueDetail,
        where: '${LeagueDetailFields.id} = ?',
        whereArgs: [leagueDetail.id]).then((rows) => rows.isEmpty)) {
      await db.insert(
          LeagueDetailFields.tableLeagueDetail, leagueDetail.toJson());
    } else {
      await db.update(
          LeagueDetailFields.tableLeagueDetail, leagueDetail.toJson(),
          where: '${LeagueDetailFields.id} = ?', whereArgs: [leagueDetail.id]);
    }
  }

  Future<List<Match>> getMatches(int leagueId, int round) async {
    final db = await instance.database;
    final result = await db.query(MatchFields.tableMatch,
        columns: MatchFields.values,
        where: '${MatchFields.leagueId} = ? AND ${MatchFields.round} = ?',
        whereArgs: [leagueId, round]);
    return result.map((json) => Match.fromJson(json)).toList();
  }

  Future<List<Match>> getMatchesByDate(DateTime date) async {
    final db = await instance.database;
    final result = await db.query(MatchFields.tableMatch,
        columns: MatchFields.values,
        where: 'substr(${MatchFields.startDate}, 1, 10) = ?',
        whereArgs: [date.toString().substring(0, 10)]);
    return result.map((json) => Match.fromJson(json)).toList();
  }

  Future<void> insertMatches(List<Match> matches) async {
    final db = await instance.database;
    for (Match match in matches) {
      if (await db.query(MatchFields.tableMatch,
          where: '${MatchFields.id} = ?',
          whereArgs: [match.id]).then((rows) => rows.isEmpty)) {
        await db.insert(MatchFields.tableMatch, match.toJson());
      } else {
        await db.update(MatchFields.tableMatch, match.toJson(),
            where: '${MatchFields.id} = ?', whereArgs: [match.id]);
      }
    }
  }

  Future<MatchDetail?> getMatchDetail(int id) async {
    final db = await instance.database;
    final result = await db.query(MatchDetailFields.tableMatchDetail,
        columns: MatchDetailFields.values,
        where: '${MatchDetailFields.id} = ?',
        whereArgs: [id]);
    if (result.isEmpty) return null;
    return result.map((json) => MatchDetail.fromJson(json)).first;
  }

  Future<void> insertMatchDetail(MatchDetail matchDetail) async {
    final db = await instance.database;
    if (await db.query(MatchDetailFields.tableMatchDetail,
        where: '${MatchDetailFields.id} = ?',
        whereArgs: [matchDetail.id]).then((rows) => rows.isEmpty)) {
      await db.insert(MatchDetailFields.tableMatchDetail, matchDetail.toJson());
    } else {
      await db.update(MatchDetailFields.tableMatchDetail, matchDetail.toJson(),
          where: '${MatchDetailFields.id} = ?', whereArgs: [matchDetail.id]);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class SeasonFields {
  static const String tableSeason = 'seasons';

  static const String id = 'id';
  static const String name = 'name';
  static const String dateFrom = 'dateFrom';
  static const String dateTo = 'dateTo';

  static const List<String> values = [
    id,
    name,
    dateFrom,
    dateTo,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableSeason (
        $id INTEGER PRIMARY KEY,
        $name TEXT,
        $dateFrom TEXT,
        $dateTo TEXT
      )
    ''';
}

class MatchFields {
  static const String tableMatch = 'matches';

  static const String id = 'id';
  static const String startDate = 'startDate';
  static const String round = 'round';
  static const String leagueId = 'leagueId';
  static const String leagueName = 'leagueName';
  static const String status = 'status';
  static const String homeName = 'homeName';
  static const String awayName = 'awayName';
  static const String homeTeam = 'homeTeam';
  static const String awayTeam = 'awayTeam';
  static const String homeId = 'homeId';
  static const String awayId = 'awayId';
  static const String homeClubPhoto = 'homeClubPhoto';
  static const String awayClubPhoto = 'awayClubPhoto';
  static const String hallId = 'hallId';
  static const String hallName = 'hallName';
  static const String homeFull = 'homeFull';
  static const String homeClean = 'homeClean';
  static const String homeSetPoints = 'homeSetPoints';
  static const String homeTeamPoints = 'homeTeamPoints';
  static const String homeTotal = 'homeTotal';
  static const String awayFull = 'awayFull';
  static const String awayClean = 'awayClean';
  static const String awaySetPoints = 'awaySetPoints';
  static const String awayTeamPoints = 'awayTeamPoints';
  static const String awayTotal = 'awayTotal';
  static const String videoUrl = 'videoUrl';

  static List<String> values = [
    id,
    startDate,
    round,
    leagueId,
    leagueName,
    status,
    homeName,
    awayName,
    homeTeam,
    awayTeam,
    homeId,
    awayId,
    homeClubPhoto,
    awayClubPhoto,
    hallId,
    hallName,
    homeFull,
    homeClean,
    homeSetPoints,
    homeTeamPoints,
    homeTotal,
    awayFull,
    awayClean,
    awaySetPoints,
    awayTeamPoints,
    awayTotal,
    videoUrl,
  ];

  static const String createTableQuery = '''
    CREATE TABLE $tableMatch (
      $id INTEGER PRIMARY KEY,
      $startDate TEXT,
      $round INTEGER,
      $leagueId INTEGER,
      $leagueName TEXT,
      $status TEXT,
      $homeName TEXT,
      $awayName TEXT,
      $homeTeam TEXT,
      $awayTeam TEXT,
      $homeId INTEGER,
      $awayId INTEGER,
      $homeClubPhoto TEXT,
      $awayClubPhoto TEXT,
      $hallId INTEGER,
      $hallName TEXT,
      $homeFull INT,
      $homeClean INT,
      $homeSetPoints INT,
      $homeTeamPoints INT,
      $homeTotal INT,
      $awayFull INT,
      $awayClean INT,
      $awaySetPoints INT,
      $awayTeamPoints INT,
      $awayTotal INT,
      $videoUrl TEXT
    )
  ''';
}

class MatchDetailFields {
  static const String tableMatchDetail = 'matchDetails';

  static const String id = 'id';
  static const String created = 'created';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String status = 'status';
  static const String round = 'round';
  static const String hallId = 'hallId';
  static const String homeTeam = 'homeTeam';
  static const String awayTeam = 'awayTeam';
  static const String referee = 'referee';
  static const String secondReferee = 'secondReferee';
  static const String league = 'league';
  static const String videoUrl = 'videoUrl';
  static const String description = 'description';
  static const String note = 'note';
  static const String substitutions = 'substitutions';
  static const String lineUp = 'lineUp';
  static const String teamResult = 'teamResult';
  static const String sprints = 'sprints';

  static const List<String> values = [
    id,
    created,
    startDate,
    endDate,
    status,
    round,
    hallId,
    homeTeam,
    awayTeam,
    referee,
    secondReferee,
    league,
    videoUrl,
    description,
    note,
    substitutions,
    lineUp,
    teamResult,
    sprints,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableMatchDetail (
        $id INTEGER PRIMARY KEY,
        $created TEXT,
        $startDate TEXT,
        $endDate TEXT,
        $status TEXT,
        $round INTEGER,
        $hallId INTEGER,
        $homeTeam TEXT,
        $awayTeam TEXT,
        $referee TEXT,
        $secondReferee TEXT,
        $league TEXT,
        $videoUrl TEXT,
        $description TEXT,
        $note TEXT,
        $substitutions TEXT,
        $lineUp TEXT,
        $teamResult TEXT,
        $sprints TEXT
      )
    ''';
}

class LeagueFields {
  static const String tableLeague = 'leagues';

  static const String id = 'id';
  static const String name = 'name';
  static const String playerCount = 'playerCount';
  static const String playerSumCount = 'playerSumCount';
  static const String throwCount = 'throwCount';
  static const String lanesCount = 'lanesCount';
  static const String sprintPlayerCount = 'sprintPlayerCount';
  static const String scoring = 'scoring';
  static const String note = 'note';
  static const String active = 'active';
  static const String defaultAverages = 'defaultAverages';
  static const String defaultTables = 'defaultTables';
  static const String categoryId = 'categoryId';
  static const String created = 'created';
  static const String seasonId = 'seasonId';
  static const String countryIds = 'countryIds';
  static const String category = 'category';

  static const List<String> values = [
    id,
    name,
    playerCount,
    playerSumCount,
    throwCount,
    lanesCount,
    sprintPlayerCount,
    scoring,
    note,
    active,
    defaultAverages,
    defaultTables,
    categoryId,
    created,
    seasonId,
    countryIds,
    category,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableLeague (
        $id INTEGER PRIMARY KEY,
        $name TEXT,
        $playerCount INTEGER,
        $playerSumCount INTEGER,
        $throwCount INTEGER,
        $lanesCount INTEGER,
        $sprintPlayerCount INTEGER,
        $scoring TEXT,
        $note TEXT,
        $active INTEGER,
        $defaultAverages INTEGER,
        $defaultTables INTEGER,
        $categoryId INTEGER,
        $created TEXT,
        $seasonId INTEGER,
        $countryIds TEXT,
        $category TEXT
      )
    ''';
}

class LeagueDetailFields {
  static const String tableLeagueDetail = 'leagueDetails';

  static const String id = 'id';
  static const String name = 'name';
  static const String playerCount = 'playerCount';
  static const String playerSumCount = 'playerSumCount';
  static const String throwCount = 'throwCount';
  static const String lanesCount = 'lanesCount';
  static const String sprintPlayerCount = 'sprintPlayerCount';
  static const String scoring = 'scoring';
  static const String note = 'note';
  static const String active = 'active';
  static const String defaultAverages = 'defaultAverages';
  static const String defaultTables = 'defaultTables';
  static const String categoryId = 'categoryId';
  static const String created = 'created';
  static const String seasonId = 'seasonId';
  static const String countryIds = 'countryIds';
  static const String playoff = 'playoff';
  static const String season = 'season';
  static const String country = 'country';
  static const String secondCountry = 'secondCountry';
  static const String teams = 'teams';
  static const String tables = 'tables';
  static const String averages = 'averages';

  static const List<String> values = [
    id,
    name,
    playerCount,
    playerSumCount,
    throwCount,
    lanesCount,
    sprintPlayerCount,
    scoring,
    note,
    active,
    defaultAverages,
    defaultTables,
    categoryId,
    created,
    seasonId,
    countryIds,
    playoff,
    season,
    country,
    secondCountry,
    teams,
    tables,
    averages,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableLeagueDetail (
        $id INTEGER PRIMARY KEY,
        $name TEXT,
        $playerCount INTEGER,
        $playerSumCount INTEGER,
        $throwCount INTEGER,
        $lanesCount INTEGER,
        $sprintPlayerCount INTEGER,
        $scoring TEXT,
        $note TEXT,
        $active TEXT,
        $defaultAverages TEXT,
        $defaultTables TEXT,
        $categoryId INT,
        $created TEXT,
        $seasonId INTEGER,
        $countryIds TEXT,
        $playoff TEXT,
        $season TEXT,
        $country TEXT,
        $secondCountry TEXT,
        $teams TEXT,
        $tables TEXT,
        $averages TEXT
      )
    ''';
}
