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

class MatchDetailFields {
  static const String tableMatchDetail = 'matchDetails';

  static const String id = 'id';
  static const String created = 'created';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String status = 'status';
  static const String round = 'round';
  static const String hallId = 'hallId';
  static const String homeTeam = 'homeTeam';
  static const String awayTeam = 'awayTeam';
  static const String referee = 'referee';
  static const String secondReferee = 'secondReferee';
  static const String league = 'league';
  static const String videoUrl = 'videoUrl';
  static const String description = 'description';
  static const String note = 'note';
  static const String substitutions = 'substitutions';
  static const String lineUp = 'lineUp';
  static const String teamResult = 'teamResult';
  static const String sprints = 'sprints';

  static const List<String> values = [
    id,
    created,
    startDate,
    endDate,
    status,
    round,
    hallId,
    homeTeam,
    awayTeam,
    referee,
    secondReferee,
    league,
    videoUrl,
    description,
    note,
    substitutions,
    lineUp,
    teamResult,
    sprints,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableMatchDetail (
        $id INTEGER PRIMARY KEY,
        $created TEXT,
        $startDate TEXT,
        $endDate TEXT,
        $status TEXT,
        $round INTEGER,
        $hallId INTEGER,
        $homeTeam TEXT,
        $awayTeam TEXT,
        $referee TEXT,
        $secondReferee TEXT,
        $league TEXT,
        $videoUrl TEXT,
        $description TEXT,
        $note TEXT,
        $substitutions TEXT,
        $lineUp TEXT,
        $teamResult TEXT,
        $sprints TEXT
      )
    ''';
}
