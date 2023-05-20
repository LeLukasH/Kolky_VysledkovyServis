import 'dart:convert';

import 'player.dart';
import 'season.dart';
import 'match.dart';

PlayerResults playerResultsFromJson(String str) =>
    PlayerResults.fromJson(json.decode(str));

String playerResultsToJson(PlayerResults data) => json.encode(data.toJson());

class PlayerResults {
  final List<PlayerResult> list;
  final List<dynamic> cards;
  final Season season;
  final Average average;

  PlayerResults({
    required this.list,
    required this.cards,
    required this.season,
    required this.average,
  });

  factory PlayerResults.fromJson(Map<String, dynamic> json) => PlayerResults(
        list: List<PlayerResult>.from(
            json["list"].map((x) => PlayerResult.fromJson(x))),
        cards: List<dynamic>.from(json["cards"].map((x) => x)),
        season: Season.fromJson(json["season"]),
        average: Average.fromJson(json["average"]),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "cards": List<dynamic>.from(cards.map((x) => x)),
        "season": season.toJson(),
        "average": average.toJson(),
      };
}

class PlayerResult {
  final int id;
  final int matchId;
  final dynamic tournamentId;
  final dynamic tournamentRoundId;
  final int teamId;
  final dynamic clubId;
  final int playerOrder;
  final int? changeThrow;
  final dynamic throwsCount;
  final int full;
  final int clean;
  final int total;
  final int faults;
  final dynamic setPoints;
  final dynamic points;
  final dynamic suddenVictory;
  final Player player;
  final dynamic otherPlayer;
  final dynamic specialName;
  final DateTime created;
  final Match match;
  final dynamic tournament;
  final dynamic tournamentRound;

  PlayerResult({
    required this.id,
    required this.matchId,
    this.tournamentId,
    this.tournamentRoundId,
    required this.teamId,
    this.clubId,
    required this.playerOrder,
    this.changeThrow,
    this.throwsCount,
    required this.full,
    required this.clean,
    required this.total,
    required this.faults,
    required this.setPoints,
    required this.points,
    this.suddenVictory,
    required this.player,
    this.otherPlayer,
    this.specialName,
    required this.created,
    required this.match,
    this.tournament,
    this.tournamentRound,
  });

  factory PlayerResult.fromJson(Map<String, dynamic> json) => PlayerResult(
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
        setPoints: json["setPoints"]?.toDouble(),
        points: json["points"],
        suddenVictory: json["suddenVictory"],
        player: Player.fromJson(json["player"]),
        otherPlayer: json["otherPlayer"],
        specialName: json["specialName"],
        created: DateTime.parse(json["created"]),
        match: Match.fromJson(json["match"]),
        tournament: json["tournament"],
        tournamentRound: json["tournamentRound"],
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
        "player": player.toJson(),
        "otherPlayer": otherPlayer,
        "specialName": specialName,
        "created": created.toIso8601String(),
        "match": match.toJson(),
        "tournament": tournament,
        "tournamentRound": tournamentRound,
      };
}

class Average {
  final int count;
  final int playerId;
  final int hallCount;
  final String firstName;
  final String lastName;
  final int teamId;
  final String teamName;
  final double full;
  final double clean;
  final double total;
  final int faults;
  final double faultsAverage;
  final dynamic setPoints;
  final dynamic points;
  final int maxTotal;
  final int order;

  Average({
    required this.count,
    required this.playerId,
    required this.hallCount,
    required this.firstName,
    required this.lastName,
    required this.teamId,
    required this.teamName,
    required this.full,
    required this.clean,
    required this.total,
    required this.faults,
    required this.faultsAverage,
    required this.setPoints,
    required this.points,
    required this.maxTotal,
    required this.order,
  });

  factory Average.fromJson(Map<String, dynamic> json) => Average(
        count: json["count"],
        playerId: json["playerId"],
        hallCount: json["hallCount"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        teamId: json["teamId"],
        teamName: json["teamName"],
        full: json["full"]?.toDouble(),
        clean: json["clean"]?.toDouble(),
        total: json["total"]?.toDouble(),
        faults: json["faults"],
        faultsAverage: json["faultsAverage"]?.toDouble(),
        setPoints: json["setPoints"],
        points: json["points"],
        maxTotal: json["maxTotal"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "playerId": playerId,
        "hallCount": hallCount,
        "firstName": firstName,
        "lastName": lastName,
        "teamId": teamId,
        "teamName": teamName,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "faultsAverage": faultsAverage,
        "setPoints": setPoints,
        "points": points,
        "maxTotal": maxTotal,
        "order": order,
      };
}
