import 'dart:convert';

import 'admin.dart';
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
    required this.modified,
    required this.seasonId,
    required this.countryIds,
    this.playoff,
    required this.admin,
    required this.season,
    required this.country,
    required this.secondCountry,
    required this.teams,
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
  bool active;
  bool defaultAverages;
  bool defaultTables;
  int categoryId;
  DateTime? created;
  DateTime? modified;
  int seasonId;
  List<int> countryIds;
  dynamic playoff;
  Admin? admin;
  Season? season;
  Country? country;
  Country? secondCountry;
  List<Team>? teams;
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
        active: json["active"],
        defaultAverages: json["defaultAverages"],
        defaultTables: json["defaultTables"],
        categoryId: json["categoryId"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        seasonId: json["seasonId"],
        countryIds: List<int>.from(json["countryIds"].map((x) => x)),
        playoff: json["playoff"],
        admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
        season: json["season"] != null ? Season.fromJson(json["season"]) : null,
        country:
            json["country"] != null ? Country.fromJson(json["country"]) : null,
        secondCountry: json["secondCountry"] != null
            ? Country.fromJson(json["secondCountry"])
            : null,
        teams: json["teams"] != null
            ? List<Team>.from(json["teams"].map((x) => Team.fromJson(x)))
            : null,
        tables: json["tables"] != null
            ? List<dynamic>.from(json["tables"].map((x) => x))
            : null,
        averages: json["averages"] != null
            ? List<dynamic>.from(json["averages"].map((x) => x))
            : null,
      );
}
