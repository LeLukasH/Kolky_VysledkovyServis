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
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
      status: statusValues.map[json["status"]],
      round: json["round"],
      hallId: json["hallId"],
      homeTeam: Team.fromJson(json["homeTeam"] is String
          ? jsonDecode(json["homeTeam"])
          : json["homeTeam"]),
      awayTeam: Team.fromJson(json["awayTeam"] is String
          ? jsonDecode(json["awayTeam"])
          : json["awayTeam"]),
      referee: Referee.fromJson(json["referee"] is String
          ? jsonDecode(json["referee"])
          : json["referee"]),
      secondReferee: json["secondReferee"] != null
          ? Referee.fromJson(json["secondReferee"] is String
              ? jsonDecode(json["secondReferee"])
              : json["secondReferee"])
          : null,
      league: League.fromJson(json["league"] is String
          ? jsonDecode(json["league"])
          : json["league"]),
      videoUrl: json["videoUrl"],
      description: json["description"],
      note: json["note"],
      substitutions: List<Substitution>.from((json["substitutions"] is String
              ? jsonDecode(json["substitutions"])
              : json["substitutions"])
          .map((x) => Substitution.fromJson(x))),
      lineUp: LineUps.fromJson(json["lineUp"] is String
          ? jsonDecode(json["lineUp"])
          : json["lineUp"]),
      teamResult: TeamsResults.fromJson(json["teamResult"] is String
          ? jsonDecode(json["teamResult"])
          : json["teamResult"]),
      sprints: List<Sprint>.from((json["sprints"] is String ? jsonDecode(json["sprints"]) : json["sprints"]).map((x) => Sprint.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate != null ? endDate?.toIso8601String() : null,
        "status": statusValues.reverse[status],
        "round": round,
        "hallId": hallId,
        "homeTeam": jsonEncode(homeTeam.toJson()),
        "awayTeam": jsonEncode(awayTeam.toJson()),
        "referee": jsonEncode(referee!.toJson()),
        "secondReferee":
            secondReferee != null ? jsonEncode(secondReferee!.toJson()) : null,
        "league": jsonEncode(league.toJson()),
        "videoUrl": videoUrl,
        "description": description,
        "note": note,
        "substitutions":
            jsonEncode(substitutions.map((x) => x.toJson()).toList()),
        "lineUp": jsonEncode(lineUp.toJson()),
        "teamResult": jsonEncode(teamResult.toJson()),
        "sprints": jsonEncode(sprints!.map((x) => x.toJson()).toList()),
      };
}