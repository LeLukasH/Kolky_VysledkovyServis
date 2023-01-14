import 'dart:convert';

Tournaments? tournamentsFromJson(String str) =>
    Tournaments.fromJson(json.decode(str));

String tournamentsToJson(Tournaments? data) => json.encode(data!.toJson());

class Tournaments {
  Tournaments({
    this.list,
  });

  final List<Tournament?>? list;

  factory Tournaments.fromJson(Map<String, dynamic> json) => Tournaments(
        list: json["list"] == null
            ? []
            : List<Tournament?>.from(
                json["list"]!.map((x) => Tournament.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x!.toJson())),
      };
}

class Tournament {
  Tournament({
    this.id,
    this.name,
    this.active,
    this.seasonId,
    this.countryId,
    this.tournamentGroupId,
    this.createdBy,
    this.created,
    this.modified,
    this.tournamentGroup,
  });

  final int? id;
  final String? name;
  final bool? active;
  final int? seasonId;
  final int? countryId;
  final int? tournamentGroupId;
  final int? createdBy;
  final String? created;
  final DateTime? modified;
  final TournamentGroup? tournamentGroup;

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        seasonId: json["seasonId"],
        countryId: json["countryId"],
        tournamentGroupId: json["tournamentGroupId"],
        createdBy: json["createdBy"],
        created: json["created"],
        modified:
            json["modified"] != null ? DateTime.parse(json["modified"]) : null,
        tournamentGroup: TournamentGroup.fromJson(json["tournamentGroup"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "seasonId": seasonId,
        "countryId": countryId,
        "tournamentGroupId": tournamentGroupId,
        "createdBy": createdBy,
        "created": created,
        "modified": modified?.toIso8601String(),
        "tournamentGroup": tournamentGroup!.toJson(),
      };
}

class TournamentGroup {
  TournamentGroup({
    this.id,
    this.name,
    this.countryId,
    this.parentTournamentGroupId,
    this.created,
    this.modified,
    this.parentTournamentGroup,
  });

  final int? id;
  final String? name;
  final int? countryId;
  final int? parentTournamentGroupId;
  final DateTime? created;
  final DateTime? modified;
  final TournamentGroup? parentTournamentGroup;

  factory TournamentGroup.fromJson(Map<String, dynamic> json) =>
      TournamentGroup(
        id: json["id"],
        name: json["name"],
        countryId: json["countryId"],
        parentTournamentGroupId: json["parentTournamentGroupId"],
        created: DateTime.parse(json["created"]),
        modified:
            json["modified"] != null ? DateTime.parse(json["modified"]) : null,
        parentTournamentGroup: json["parentTournamentGroup"] != null
            ? TournamentGroup.fromJson(json["parentTournamentGroup"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryId": countryId,
        "parentTournamentGroupId": parentTournamentGroupId,
        "created": created?.toIso8601String(),
        "modified": modified,
        "parentTournamentGroup": parentTournamentGroup,
      };
}
