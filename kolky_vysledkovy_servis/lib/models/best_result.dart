import 'dart:convert';

List<BestResult> bestResultFromJson(String str) => json.decode(str) == null
    ? []
    : List<BestResult>.from(
        json.decode(str)!.map((x) => BestResult.fromJson(x)));

String bestResultToJson(List<BestResult?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class BestResult {
  BestResult({
    this.firstName,
    this.lastName,
    this.playerId,
    this.matchId,
    this.teamId,
    this.teamName,
    this.full,
    this.clean,
    this.total,
    this.faults,
    this.setPoints,
    this.hallId,
    this.hallName,
    this.teamHallId,
    this.round,
  });

  final String? firstName;
  final String? lastName;
  final int? playerId;
  final int? matchId;
  final int? teamId;
  final String? teamName;
  final int? full;
  final int? clean;
  final int? total;
  final int? faults;
  final dynamic setPoints;
  final int? hallId;
  final String? hallName;
  final int? teamHallId;
  final int? round;

  factory BestResult.fromJson(Map<String, dynamic> json) => BestResult(
        firstName: json["firstName"],
        lastName: json["lastName"],
        playerId: json["playerId"],
        matchId: json["matchId"],
        teamId: json["teamId"],
        teamName: json["teamName"],
        full: json["full"],
        clean: json["clean"],
        total: json["total"],
        faults: json["faults"],
        setPoints: json["setPoints"],
        hallId: json["hallId"],
        hallName: json["hallName"],
        teamHallId: json["teamHallId"],
        round: json["round"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "playerId": playerId,
        "matchId": matchId,
        "teamId": teamId,
        "teamName": teamName,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "setPoints": setPoints,
        "hallId": hallId,
        "hallName": hallName,
        "teamHallId": teamHallId,
        "round": round,
      };
}
