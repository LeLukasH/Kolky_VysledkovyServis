import 'dart:convert';

import 'status.dart';
import 'team.dart';

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
    this.homeTeam,
    this.awayTeam,
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
  int? leagueId;
  String? leagueName;
  Status? status;
  String? homeName;
  String? awayName;
  Team? homeTeam;
  Team? awayTeam;
  int? homeId;
  int? awayId;
  dynamic homeClubPhoto;
  dynamic awayClubPhoto;
  int hallId;
  String? hallName;
  dynamic homeFull;
  dynamic homeClean;
  dynamic homeSetPoints;
  dynamic homeTeamPoints;
  dynamic homeTotal;
  dynamic awayFull;
  dynamic awayClean;
  dynamic awaySetPoints;
  dynamic awayTeamPoints;
  dynamic awayTotal;
  dynamic videoUrl;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        round: json["round"],
        leagueId: json["leagueId"] ?? null,
        leagueName: json["leagueName"] ?? null,
        status: statusValues.map[json["status"]],
        homeName: json["homeName"] ?? null,
        awayName: json["awayName"] ?? null,
        homeTeam:
            json["homeTeam"] != null ? Team.fromJson(json["homeTeam"]) : null,
        awayTeam:
            json["awayTeam"] != null ? Team.fromJson(json["awayTeam"]) : null,
        homeId: json["homeId"] ?? null,
        awayId: json["awayId"] ?? null,
        homeClubPhoto: json["homeClubPhoto"],
        awayClubPhoto: json["awayClubPhoto"],
        hallId: json["hallId"],
        hallName: json["hallName"] ?? null,
        homeFull: json["homeFull"] ?? null,
        homeClean: json["homeClean"] ?? null,
        homeSetPoints: json["homeSetPoints"] == null
            ? null
            : json["homeSetPoints"].toDouble(),
        homeTeamPoints: json["homeTeamPoints"] == null
            ? null
            : json["homeTeamPoints"].toDouble(),
        homeTotal: json["homeTotal"] ?? null,
        awayFull: json["awayFull"] ?? null,
        awayClean: json["awayClean"] ?? null,
        awaySetPoints: json["awaySetPoints"] == null
            ? null
            : json["awaySetPoints"].toDouble(),
        awayTeamPoints: json["awayTeamPoints"] == null
            ? null
            : json["awayTeamPoints"].toDouble(),
        awayTotal: json["awayTotal"] ?? null,
        videoUrl: json["videoUrl"] ?? null,
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
