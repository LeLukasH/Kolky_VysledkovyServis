// To parse this JSON data, do
//
//     final matches = matchesFromJson(jsonString);

import 'dart:convert';

Matches matchesFromJson(String str) => Matches.fromJson(json.decode(str));

String matchesToJson(Matches data) => json.encode(data.toJson());

class Matches {
  Matches({
    required this.list,
  });

  List<Match> list;

  factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        list: List<Match>.from(json["list"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Match {
  Match({
    required this.id,
    required this.startDate,
    required this.round,
    required this.leagueId,
    required this.leagueName,
    this.status,
    required this.homeName,
    required this.awayName,
    required this.homeId,
    required this.awayId,
    this.homeClubPhoto,
    this.awayClubPhoto,
    required this.hallId,
    required this.hallName,
    required this.homeFull,
    required this.homeClean,
    required this.homeSetPoints,
    required this.homeTeamPoints,
    required this.homeTotal,
    required this.awayFull,
    required this.awayClean,
    required this.awaySetPoints,
    required this.awayTeamPoints,
    required this.awayTotal,
    required this.videoUrl,
  });

  int id;
  DateTime startDate;
  int round;
  int leagueId;
  String leagueName;
  Status? status;
  String homeName;
  String awayName;
  int homeId;
  int awayId;
  dynamic homeClubPhoto;
  dynamic awayClubPhoto;
  int hallId;
  String hallName;
  int homeFull;
  int homeClean;
  double homeSetPoints;
  double homeTeamPoints;
  int homeTotal;
  int awayFull;
  int awayClean;
  double awaySetPoints;
  double awayTeamPoints;
  int awayTotal;
  String videoUrl;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        round: json["round"],
        leagueId: json["leagueId"],
        leagueName: json["leagueName"],
        status: statusValues.map[json["status"]],
        homeName: json["homeName"],
        awayName: json["awayName"],
        homeId: json["homeId"],
        awayId: json["awayId"],
        homeClubPhoto: json["homeClubPhoto"],
        awayClubPhoto: json["awayClubPhoto"],
        hallId: json["hallId"],
        hallName: json["hallName"],
        homeFull: json["homeFull"],
        homeClean: json["homeClean"],
        homeSetPoints: json["homeSetPoints"],
        homeTeamPoints: json["homeTeamPoints"],
        homeTotal: json["homeTotal"],
        awayFull: json["awayFull"],
        awayClean: json["awayClean"],
        awaySetPoints: json["awaySetPoints"],
        awayTeamPoints: json["awayTeamPoints"],
        awayTotal: json["awayTotal"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate.toIso8601String(),
        "round": round,
        "leagueId": leagueId,
        "leagueName": leagueName,
        "status": statusValues.reverse[status],
        "homeName": homeName,
        "awayName": awayName,
        "homeId": homeId,
        "awayId": awayId,
        "homeClubPhoto": homeClubPhoto,
        "awayClubPhoto": awayClubPhoto,
        "hallId": hallId,
        "hallName": hallName,
        "homeFull": homeFull,
        "homeClean": homeClean,
        "homeSetPoints": homeSetPoints,
        "homeTeamPoints": homeTeamPoints,
        "homeTotal": homeTotal,
        "awayFull": awayFull,
        "awayClean": awayClean,
        "awaySetPoints": awaySetPoints,
        "awayTeamPoints": awayTeamPoints,
        "awayTotal": awayTotal,
        "videoUrl": videoUrl,
      };
}

enum Status { FINISHED, CONTUMATED, NEW, CANCELED }

final statusValues = EnumValues({
  "canceled": Status.CANCELED,
  "contumated": Status.CONTUMATED,
  "finished": Status.FINISHED,
  "new": Status.NEW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
