// To parse this JSON data, do
//
//     final leagues = leaguesFromJson(jsonString);

import 'dart:convert';

import 'package:kolky_vysledkovy_servis/models/category.dart';

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
    this.modified,
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
  bool active;
  bool defaultAverages;
  bool defaultTables;
  int categoryId;
  DateTime created;
  dynamic modified;
  int seasonId;
  List<int> countryIds;
  Category category;

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
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        seasonId: json["seasonId"],
        countryIds: List<int>.from(json["countryIds"].map((x) => x)),
        category: Category.fromJson(json["category"]),
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
        "modified": modified.toIso8601String(),
        "seasonId": seasonId,
        "countryIds": List<dynamic>.from(countryIds.map((x) => x)),
        "category": category.toJson(),
      };
}
