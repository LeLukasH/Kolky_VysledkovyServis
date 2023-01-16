import 'dart:convert';

IndividualResults? individualResultsFromJson(String str) =>
    IndividualResults.fromJson(json.decode(str));

String individualResultsToJson(IndividualResults? data) =>
    json.encode(data!.toJson());

class IndividualResults {
  IndividualResults({
    this.averages,
    this.outOfOrder,
  });

  final List<IndividualResult>? averages;
  final List<IndividualResult>? outOfOrder;

  factory IndividualResults.fromJson(Map<String, dynamic> json) =>
      IndividualResults(
        averages: json["averages"] == null
            ? []
            : List<IndividualResult>.from(
                json["averages"]!.map((x) => IndividualResult.fromJson(x))),
        outOfOrder: json["outOfOrder"] == null
            ? []
            : List<IndividualResult>.from(
                json["outOfOrder"]!.map((x) => IndividualResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "averages": averages == null
            ? []
            : List<dynamic>.from(averages!.map((x) => x.toJson())),
        "outOfOrder": outOfOrder == null
            ? []
            : List<dynamic>.from(outOfOrder!.map((x) => x.toJson())),
      };
}

class IndividualResult {
  IndividualResult({
    this.count,
    this.playerId,
    this.hallCount,
    this.firstName,
    this.lastName,
    this.nameMark,
    this.teamId,
    this.teamName,
    this.full,
    this.clean,
    this.total,
    this.faults,
    this.faultsAverage,
    this.setPoints,
    this.points,
    this.maxTotal,
  });

  final int? count;
  final int? playerId;
  final int? hallCount;
  final String? firstName;
  final String? lastName;
  final String? nameMark;
  final int? teamId;
  final String? teamName;
  final double? full;
  final double? clean;
  final double? total;
  final int? faults;
  final double? faultsAverage;
  final double? setPoints;
  final double? points;
  final int? maxTotal;
  int? order;

  factory IndividualResult.fromJson(Map<String, dynamic> json) =>
      IndividualResult(
        count: json["count"],
        playerId: json["playerId"],
        hallCount: json["hallCount"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        nameMark: json["nameMark"],
        teamId: json["teamId"],
        teamName: json["teamName"],
        full: json["full"].toDouble(),
        clean: json["clean"].toDouble(),
        total: json["total"].toDouble(),
        faults: json["faults"],
        faultsAverage: json["faultsAverage"].toDouble(),
        setPoints: json["setPoints"].toDouble(),
        points: json["points"].toDouble(),
        maxTotal: json["maxTotal"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "playerId": playerId,
        "hallCount": hallCount,
        "firstName": firstName,
        "lastName": lastName,
        "nameMark": nameMark,
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
      };
}
