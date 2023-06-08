import 'dart:convert';

import 'category.dart';

Leagues leaguesFromJson(String str) => Leagues.fromJson(json.decode(str));

String leaguesToJson(Leagues data) => json.encode(data.toJson());

class Leagues {
  Leagues({
    required this.list,
  });

  List<League> list;

  factory Leagues.fromJson(Map<String, dynamic> json) => Leagues(
        list: List<League>.from(json["list"].map((x) => League.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class League {
  League({
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
    required this.category,
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
  DateTime created;
  int seasonId;
  List<int> countryIds;
  Category? category;

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        name: json["name"],
        playerCount: json["playerCount"],
        playerSumCount: json["playerSumCount"],
        throwCount: json["throwCount"],
        lanesCount: json["lanesCount"],
        sprintPlayerCount: json["sprintPlayerCount"],
        scoring: json["scoring"],
        note: json["note"],
        active: json["active"],
        defaultAverages: json["defaultAverages"],
        defaultTables: json["defaultTables"],
        categoryId: json["categoryId"],
        created: DateTime.parse(json["created"]),
        seasonId: json["seasonId"],
        countryIds: List<int>.from(json["countryIds"].map((x) => x)),
        category: json["category"] != null
            ? Category.fromJson(json["category"] is String
                ? jsonDecode(json["category"])
                : json["category"])
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
        "active": active,
        "defaultAverages": defaultAverages,
        "defaultTables": defaultTables,
        "categoryId": categoryId,
        "created": created.toIso8601String(),
        "seasonId": seasonId,
        "countryIds": List<dynamic>.from(countryIds.map((x) => x)),
        "category": category != null ? jsonEncode(category!.toJson()) : null,
      };
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
