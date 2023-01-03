// To parse this JSON data, do
//
//     final averagesOfIndividuals = averagesOfIndividualsFromJson(jsonString);

import 'dart:convert';

import 'team.dart';

AveragesOfIndividuals averagesOfIndividualsFromJson(String str) =>
    AveragesOfIndividuals.fromJson(json.decode(str));

String averagesOfIndividualsToJson(AveragesOfIndividuals data) =>
    json.encode(data.toJson());

class AveragesOfIndividuals {
  AveragesOfIndividuals({
    required this.averagesOfIndividualsRows,
    required this.extraPoints,
  });

  List<AveragesOfIndividualsRow> averagesOfIndividualsRows;
  List<dynamic> extraPoints;

  factory AveragesOfIndividuals.fromJson(Map<String, dynamic> json) =>
      AveragesOfIndividuals(
        averagesOfIndividualsRows: List<AveragesOfIndividualsRow>.from(
            json["averagesOfIndividualsRows"]
                .map((x) => AveragesOfIndividualsRow.fromJson(x))),
        extraPoints: List<dynamic>.from(json["extraPoints"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "averagesOfIndividualsRows": List<dynamic>.from(
            averagesOfIndividualsRows.map((x) => x.toJson())),
        "extraPoints": List<dynamic>.from(extraPoints.map((x) => x)),
      };
}

class AveragesOfIndividualsRow {
  AveragesOfIndividualsRow({
    required this.leagueId,
    required this.teamId,
    required this.teamName,
    required this.hallCount,
    required this.countableHalls,
    required this.full,
    required this.clean,
    required this.total,
    required this.faults,
    required this.setPoints,
    required this.teamPoints,
    required this.tablePoints,
    required this.againstTeamPoints,
    required this.againstSetPoints,
    required this.countableMatchCount,
    required this.count,
    required this.wins,
    required this.loses,
    required this.draws,
    required this.order,
    required this.team,
  });

  int leagueId;
  int teamId;
  String teamName;
  int hallCount;
  int countableHalls;
  double full;
  double clean;
  double total;
  int faults;
  double setPoints;
  double teamPoints;
  int tablePoints;
  double againstTeamPoints;
  double againstSetPoints;
  int countableMatchCount;
  int count;
  int wins;
  int loses;
  int draws;
  int order;
  Team team;

  factory AveragesOfIndividualsRow.fromJson(Map<String, dynamic> json) =>
      AveragesOfIndividualsRow(
        leagueId: json["leagueId"],
        teamId: json["teamId"],
        teamName: json["teamName"],
        hallCount: json["hallCount"],
        countableHalls: json["countableHalls"],
        full: json["full"].toDouble(),
        clean: json["clean"].toDouble(),
        total: json["total"].toDouble(),
        faults: json["faults"],
        setPoints: json["setPoints"].toDouble(),
        teamPoints: json["teamPoints"].toDouble(),
        tablePoints: json["tablePoints"],
        againstTeamPoints: json["againstTeamPoints"].toDouble(),
        againstSetPoints: json["againstSetPoints"].toDouble(),
        countableMatchCount: json["countableMatchCount"],
        count: json["count"],
        wins: json["wins"],
        loses: json["loses"],
        draws: json["draws"],
        order: json["order"],
        team: Team.fromJson(json["team"]),
      );

  Map<String, dynamic> toJson() => {
        "leagueId": leagueId,
        "teamId": teamId,
        "teamName": teamName,
        "hallCount": hallCount,
        "countableHalls": countableHalls,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "setPoints": setPoints,
        "teamPoints": teamPoints,
        "tablePoints": tablePoints,
        "againstTeamPoints": againstTeamPoints,
        "againstSetPoints": againstSetPoints,
        "countableMatchCount": countableMatchCount,
        "count": count,
        "wins": wins,
        "loses": loses,
        "draws": draws,
        "order": order,
        "team": team.toJson(),
      };
}
