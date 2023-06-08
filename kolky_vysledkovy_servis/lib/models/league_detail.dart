import 'dart:convert';

import 'country.dart';
import 'season.dart';
import 'team.dart';

LeagueDetail leagueDetailFromJson(String str) =>
    LeagueDetail.fromJson(json.decode(str));

class LeagueDetail {
  LeagueDetail({
    required this.id,
    required this.name,
    required this.playerCount,
    required this.playerSumCount,
    required this.throwCount,
    required this.lanesCount,
    required this.sprintPlayerCount,
    required this.scoring,
    this.note,
    required this.active,
    required this.defaultAverages,
    required this.defaultTables,
    required this.categoryId,
    required this.created,
    required this.seasonId,
    required this.countryIds,
    this.playoff,
    required this.season,
    required this.country,
    required this.secondCountry,
    required this.tables,
    required this.averages,
  });

  int id;
  String name;
  int playerCount;
  int playerSumCount;
  int throwCount;
  int lanesCount;
  int sprintPlayerCount;
  String scoring;
  dynamic note;
  dynamic active;
  dynamic defaultAverages;
  dynamic defaultTables;
  int categoryId;
  DateTime? created;
  int seasonId;
  List<int> countryIds;
  dynamic playoff;
  Season? season;
  Country? country;
  Country? secondCountry;
  List<dynamic>? tables;
  List<dynamic>? averages;

  factory LeagueDetail.fromJson(Map<String, dynamic> json) => LeagueDetail(
        id: json["id"],
        name: json["name"],
        playerCount: json["playerCount"],
        playerSumCount: json["playerSumCount"],
        throwCount: json["throwCount"],
        lanesCount: json["lanesCount"],
        sprintPlayerCount: json["sprintPlayerCount"],
        scoring: json["scoring"],
        note: json["note"],
        active: json["active"] is String
            ? jsonDecode(json["active"])
            : json["active"],
        defaultAverages: json["defaultAverages"] is String
            ? jsonDecode(json["defaultAverages"])
            : json["defaultAverages"],
        defaultTables: json["defaultTables"] is String
            ? jsonDecode(json["defaultTables"])
            : json["defaultTables"],
        categoryId: json["categoryId"],
        created:
            json["created"] != null ? DateTime.parse(json["created"]) : null,
        seasonId: json["seasonId"],
        countryIds: List<int>.from(json["countryIds"].map((x) => x)),
        playoff: json["playoff"],
        season: json["season"] != null
            ? Season.fromJson(json["season"] is String
                ? jsonDecode(json["season"])
                : json["season"])
            : null,
        country: json["country"] != null
            ? Country.fromJson(json["country"] is String
                ? jsonDecode(json["country"])
                : json["country"])
            : null,
        secondCountry: json["secondCountry"] != null
            ? Country.fromJson(json["secondCountry"] is String
                ? jsonDecode(json["secondCountry"])
                : json["secondCountry"])
            : null,
        tables: json["tables"] != null
            ? List<dynamic>.from((json["tables"] is String
                    ? jsonDecode(json["tables"])
                    : json["tables"])
                .map((x) => Team.fromJson(x)))
            : null,
        averages: json["averages"] != null
            ? List<dynamic>.from((json["averages"] is String
                    ? jsonDecode(json["averages"])
                    : json["averages"])
                .map((x) => Team.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "playerCount": playerCount,
        "playerSumCount": playerSumCount,
        "throwCount": throwCount,
        "lanesCount": lanesCount,
        "sprintPlayerCount": sprintPlayerCount,
        "scoring": scoring,
        "note": note,
        "active": jsonEncode(active),
        "defaultAverages": jsonEncode(defaultAverages),
        "defaultTables": jsonEncode(defaultTables),
        "categoryId": categoryId,
        "created": created?.toIso8601String(),
        "seasonId": seasonId,
        "countryIds": List<dynamic>.from(countryIds.map((x) => x)),
        "playoff": playoff,
        "season": season != null ? jsonEncode(season!.toJson()) : null,
        "country": country != null ? jsonEncode(country!.toJson()) : null,
        "secondCountry":
            secondCountry != null ? jsonEncode(secondCountry!.toJson()) : null,
        "tables": tables != null
            ? List<dynamic>.from(tables!.map((x) => jsonEncode(x)))
            : null,
        "averages": averages != null
            ? List<dynamic>.from(averages!.map((x) => jsonEncode(x)))
            : null,
      };
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
