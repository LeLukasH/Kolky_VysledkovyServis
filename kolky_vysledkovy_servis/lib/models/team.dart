import 'club.dart';

class Team {
  Team({
    required this.id,
    required this.name,
    required this.time,
    required this.day,
    required this.created,
    this.modified,
    required this.clubId,
    required this.hallId,
    required this.leagueId,
    required this.club,
  });

  int id;
  String name;
  String time;
  int day;
  DateTime created;
  dynamic modified;
  int clubId;
  int hallId;
  int leagueId;
  Club club;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        time: json["time"],
        day: json["day"],
        created: DateTime.parse(json["created"]),
        modified: json["modified"],
        clubId: json["clubId"],
        hallId: json["hallId"],
        leagueId: json["leagueId"],
        club: Club.fromJson(json["club"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
        "day": day,
        "created": created.toIso8601String(),
        "modified": modified,
        "clubId": clubId,
        "hallId": hallId,
        "leagueId": leagueId,
        "club": club.toJson(),
      };
}
