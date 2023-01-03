import 'dart:convert';

import 'hall.dart';
import 'league.dart';
import 'lineup.dart';
import 'referee.dart';
import 'substitution.dart';
import 'team.dart';
import 'teamresult.dart';

MatchDetail matchDetailFromJson(String str) =>
    MatchDetail.fromJson(json.decode(str));

String matchDetailToJson(MatchDetail data) => json.encode(data.toJson());

class MatchDetail {
  MatchDetail({
    required this.id,
    required this.created,
    required this.modified,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.round,
    required this.hallId,
    required this.emailSendCount,
    required this.homeTeam,
    required this.awayTeam,
    required this.referee,
    this.secondReferee,
    required this.league,
    required this.hall,
    this.videoUrl,
    this.description,
    this.note,
    required this.homeTeamLeader,
    required this.awayTeamLeader,
    required this.substitutions,
    required this.cards,
    required this.lineUp,
    required this.teamResult,
    required this.sprints,
  });

  int id;
  DateTime created;
  DateTime modified;
  DateTime startDate;
  DateTime endDate;
  String status;
  int round;
  int hallId;
  int emailSendCount;
  Team homeTeam;
  Team awayTeam;
  Referee referee;
  dynamic secondReferee;
  League league;
  Hall hall;
  dynamic videoUrl;
  dynamic description;
  dynamic note;
  String homeTeamLeader;
  String awayTeamLeader;
  List<Substitution> substitutions;
  List<dynamic> cards;
  LineUps lineUp;
  TeamsResults teamResult;
  List<dynamic> sprints;

  factory MatchDetail.fromJson(Map<String, dynamic> json) => MatchDetail(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        status: json["status"],
        round: json["round"],
        hallId: json["hallId"],
        emailSendCount: json["emailSendCount"],
        homeTeam: Team.fromJson(json["homeTeam"]),
        awayTeam: Team.fromJson(json["awayTeam"]),
        referee: Referee.fromJson(json["referee"]),
        secondReferee: json["secondReferee"],
        league: League.fromJson(json["league"]),
        hall: Hall.fromJson(json["hall"]),
        videoUrl: json["videoUrl"],
        description: json["description"],
        note: json["note"],
        homeTeamLeader: json["homeTeamLeader"],
        awayTeamLeader: json["awayTeamLeader"],
        substitutions: List<Substitution>.from(
            json["substitutions"].map((x) => Substitution.fromJson(x))),
        cards: List<dynamic>.from(json["cards"].map((x) => x)),
        lineUp: LineUps.fromJson(json["lineUp"]),
        teamResult: TeamsResults.fromJson(json["teamResult"]),
        sprints: List<dynamic>.from(json["sprints"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "status": status,
        "round": round,
        "hallId": hallId,
        "emailSendCount": emailSendCount,
        "homeTeam": homeTeam.toJson(),
        "awayTeam": awayTeam.toJson(),
        "referee": referee.toJson(),
        "secondReferee": secondReferee,
        "league": league.toJson(),
        "hall": hall.toJson(),
        "videoUrl": videoUrl,
        "description": description,
        "note": note,
        "homeTeamLeader": homeTeamLeader,
        "awayTeamLeader": awayTeamLeader,
        "substitutions":
            List<dynamic>.from(substitutions.map((x) => x.toJson())),
        "cards": List<dynamic>.from(cards.map((x) => x)),
        "lineUp": lineUp.toJson(),
        "teamResult": teamResult.toJson(),
        "sprints": List<dynamic>.from(sprints.map((x) => x)),
      };
}
