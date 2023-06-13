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