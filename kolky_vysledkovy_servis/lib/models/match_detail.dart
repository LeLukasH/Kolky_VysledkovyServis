import 'dart:convert';

import 'league.dart';
import 'lineup.dart';
import 'referee.dart';
import 'sprint.dart';
import 'status.dart';
import 'substitution.dart';
import 'team.dart';
import 'team_result.dart';

MatchDetail matchDetailFromJson(String str) =>
    MatchDetail.fromJson(json.decode(str));

String matchDetailToJson(MatchDetail data) => json.encode(data.toJson());

class MatchDetail {
  MatchDetail({
    required this.id,
    required this.created,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.round,
    required this.hallId,
    required this.homeTeam,
    required this.awayTeam,
    required this.referee,
    this.secondReferee,
    required this.league,
    this.videoUrl,
    this.description,
    this.note,
    required this.substitutions,
    required this.lineUp,
    required this.teamResult,
    required this.sprints,
  });

  int id;
  DateTime created;
  DateTime startDate;
  DateTime? endDate;
  Status? status;
  int round;
  int hallId;
  Team homeTeam;
  Team awayTeam;
  Referee? referee;
  dynamic secondReferee;
  League league;
  dynamic videoUrl;
  dynamic description;
  dynamic note;
  List<Substitution> substitutions;
  LineUps lineUp;
  TeamsResults teamResult;
  List<Sprint>? sprints;

  factory MatchDetail.fromJson(Map<String, dynamic> json) => MatchDetail(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        status: statusValues.map[json["status"]],
        round: json["round"],
        hallId: json["hallId"],
        homeTeam: Team.fromJson(json["homeTeam"]),
        awayTeam: Team.fromJson(json["awayTeam"]),
        referee:
            json["referee"] != null ? Referee.fromJson(json["referee"]) : null,
        secondReferee: json["secondReferee"],
        league: League.fromJson(json["league"]),
        videoUrl: json["videoUrl"],
        description: json["description"],
        note: json["note"],
        substitutions: List<Substitution>.from(
            json["substitutions"].map((x) => Substitution.fromJson(x))),
        lineUp: LineUps.fromJson(json["lineUp"]),
        teamResult: TeamsResults.fromJson(json["teamResult"]),
        sprints:
            List<Sprint>.from(json["sprints"].map((x) => Sprint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "status": status,
        "round": round,
        "hallId": hallId,
        "homeTeam": homeTeam.toJson(),
        "awayTeam": awayTeam.toJson(),
        "referee": referee!.toJson(),
        "secondReferee": secondReferee,
        "league": league.toJson(),
        "videoUrl": videoUrl,
        "description": description,
        "note": note,
        "substitutions":
            List<dynamic>.from(substitutions.map((x) => x.toJson())),
        "lineUp": lineUp.toJson(),
        "teamResult": teamResult.toJson(),
        "sprints": List<Sprint>.from(sprints!.map((x) => x)),
      };
}
