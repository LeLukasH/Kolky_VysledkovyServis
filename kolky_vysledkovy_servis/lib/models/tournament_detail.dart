import 'dart:convert';

import 'player.dart';
import 'club.dart';
import 'hall.dart';
import 'lane.dart';

TournamentDetail tournamentDetailFromJson(String str) =>
    TournamentDetail.fromJson(json.decode(str));

String tournamentDetailToJson(TournamentDetail? data) =>
    json.encode(data!.toJson());

class TournamentDetail {
  TournamentDetail({
    this.id,
    this.name,
    this.active,
    this.seasonId,
    this.countryId,
    this.tournamentGroupId,
    this.createdBy,
    this.created,
    this.modified,
    this.tournamentRounds,
  });

  final int? id;
  final String? name;
  final bool? active;
  final int? seasonId;
  final int? countryId;
  final int? tournamentGroupId;
  final int? createdBy;
  final DateTime? created;
  final dynamic modified;
  final List<TournamentRound>? tournamentRounds;

  factory TournamentDetail.fromJson(Map<String, dynamic> json) =>
      TournamentDetail(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        seasonId: json["seasonId"],
        countryId: json["countryId"],
        tournamentGroupId: json["tournamentGroupId"],
        createdBy: json["createdBy"],
        created: DateTime.parse(json["created"]),
        modified: json["modified"],
        tournamentRounds: json["tournamentRounds"] == null
            ? []
            : List<TournamentRound>.from(json["tournamentRounds"]!
                .map((x) => TournamentRound.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "seasonId": seasonId,
        "countryId": countryId,
        "tournamentGroupId": tournamentGroupId,
        "createdBy": createdBy,
        "created": created?.toIso8601String(),
        "modified": modified,
        "tournamentRounds": tournamentRounds == null
            ? []
            : List<dynamic>.from(tournamentRounds!.map((x) => x.toJson())),
      };
}

class TournamentRound {
  TournamentRound({
    this.id,
    this.tournamentId,
    this.clubId,
    this.hallId,
    this.name,
    this.status,
    this.dateFrom,
    this.dateTo,
    this.throwCount,
    this.videoUrl,
    this.comment,
    this.additionGroupBy,
    this.groupRounds,
    this.created,
    this.modified,
    this.hall,
    this.results,
    this.groupResults,
  });

  final int? id;
  final int? tournamentId;
  final int? clubId;
  final int? hallId;
  final String? name;
  final String? status;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final int? throwCount;
  final dynamic videoUrl;
  final dynamic comment;
  final String? additionGroupBy;
  final List<int?>? groupRounds;
  final DateTime? created;
  final DateTime? modified;
  final Hall? hall;
  final List<Result>? results;
  final List<GroupResult>? groupResults;

  factory TournamentRound.fromJson(Map<String, dynamic> json) =>
      TournamentRound(
        id: json["id"],
        tournamentId: json["tournamentId"],
        clubId: json["clubId"],
        hallId: json["hallId"],
        name: json["name"],
        status: json["status"],
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
        throwCount: json["throwCount"],
        videoUrl: json["videoUrl"],
        comment: json["comment"],
        additionGroupBy: json["additionGroupBy"],
        groupRounds: json["groupRounds"] == null
            ? []
            : json["groupRounds"] == null
                ? []
                : List<int?>.from(json["groupRounds"]!.map((x) => x)),
        created: DateTime.parse(json["created"]),
        modified:
            json["modified"] != null ? DateTime.parse(json["modified"]) : null,
        hall: Hall.fromJson(json["hall"]),
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        groupResults: json["groupResults"] == null
            ? []
            : json["groupResults"] == null
                ? []
                : List<GroupResult>.from(
                    json["groupResults"]!.map((x) => GroupResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournamentId": tournamentId,
        "clubId": clubId,
        "hallId": hallId,
        "name": name,
        "status": status,
        "dateFrom": dateFrom?.toIso8601String(),
        "dateTo": dateTo?.toIso8601String(),
        "throwCount": throwCount,
        "videoUrl": videoUrl,
        "comment": comment,
        "additionGroupBy": additionGroupBy,
        "groupRounds": groupRounds == null
            ? []
            : groupRounds == null
                ? []
                : List<dynamic>.from(groupRounds!.map((x) => x)),
        "created": created?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "hall": hall!.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "groupResults": groupResults == null
            ? []
            : groupResults == null
                ? []
                : List<dynamic>.from(groupResults!.map((x) => x.toJson())),
      };
}

class GroupResult {
  GroupResult({
    this.player,
    this.club,
    this.full,
    this.clean,
    this.total,
    this.faults,
    this.setPoints,
    this.points,
  });

  final Player? player;
  final Club? club;
  final int? full;
  final int? clean;
  final int? total;
  final int? faults;
  final int? setPoints;
  final int? points;

  factory GroupResult.fromJson(Map<String, dynamic> json) => GroupResult(
        player: Player.fromJson(json["player"]),
        club: Club.fromJson(json["club"]),
        full: json["full"],
        clean: json["clean"],
        total: json["total"],
        faults: json["faults"],
        setPoints: json["setPoints"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "player": player!.toJson(),
        "club": club!.toJson(),
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "setPoints": setPoints,
        "points": points,
      };
}

class Result {
  Result({
    this.id,
    this.matchId,
    this.tournamentId,
    this.tournamentRoundId,
    this.teamId,
    this.clubId,
    this.playerOrder,
    this.changeThrow,
    this.throwsCount,
    this.full,
    this.clean,
    this.total,
    this.faults,
    this.setPoints,
    this.points,
    this.suddenVictory,
    this.player,
    this.otherPlayer,
    this.specialName,
    this.created,
    this.lanes,
  });

  final int? id;
  final dynamic matchId;
  final int? tournamentId;
  final int? tournamentRoundId;
  final dynamic teamId;
  final int? clubId;
  final int? playerOrder;
  final dynamic changeThrow;
  final dynamic throwsCount;
  final int? full;
  final int? clean;
  final int? total;
  final int? faults;
  final dynamic setPoints;
  final num? points;
  final dynamic suddenVictory;
  final Player? player;
  final dynamic otherPlayer;
  final dynamic specialName;
  final DateTime? created;
  final List<Lane>? lanes;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        matchId: json["matchId"],
        tournamentId: json["tournamentId"],
        tournamentRoundId: json["tournamentRoundId"],
        teamId: json["teamId"],
        clubId: json["clubId"],
        playerOrder: json["playerOrder"],
        changeThrow: json["changeThrow"],
        throwsCount: json["throwsCount"],
        full: json["full"],
        clean: json["clean"],
        total: json["total"],
        faults: json["faults"],
        setPoints: json["setPoints"],
        points: json["points"],
        suddenVictory: json["suddenVictory"],
        player: Player.fromJson(json["player"]),
        otherPlayer: json["otherPlayer"],
        specialName: json["specialName"],
        created: DateTime.parse(json["created"]),
        lanes: json["lanes"] == null
            ? []
            : List<Lane>.from(json["lanes"]!.map((x) => Lane.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "matchId": matchId,
        "tournamentId": tournamentId,
        "tournamentRoundId": tournamentRoundId,
        "teamId": teamId,
        "clubId": clubId,
        "playerOrder": playerOrder,
        "changeThrow": changeThrow,
        "throwsCount": throwsCount,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "setPoints": setPoints,
        "points": points,
        "suddenVictory": suddenVictory,
        "player": player!.toJson(),
        "otherPlayer": otherPlayer,
        "specialName": specialName,
        "created": created?.toIso8601String(),
        "lanes": lanes == null
            ? []
            : List<dynamic>.from(lanes!.map((x) => x.toJson())),
      };
}
