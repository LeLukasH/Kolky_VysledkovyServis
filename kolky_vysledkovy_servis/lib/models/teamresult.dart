class TeamsResults {
  TeamsResults({
    this.home,
    this.away,
  });

  TeamResult? home;
  TeamResult? away;

  factory TeamsResults.fromJson(Map<String, dynamic> json) => TeamsResults(
        home: json["home"] != null ? TeamResult.fromJson(json["home"]) : null,
        away: json["away"] != null ? TeamResult.fromJson(json["away"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "home": home!.toJson(),
        "away": away!.toJson(),
      };
}

class TeamResult {
  TeamResult({
    required this.id,
    required this.matchId,
    required this.teamId,
    required this.teamState,
    required this.full,
    required this.clean,
    required this.total,
    required this.faults,
    required this.setPoints,
    required this.teamPoints,
    required this.tablePoints,
  });

  int id;
  int matchId;
  int teamId;
  String teamState;
  int full;
  int clean;
  int total;
  int faults;
  int setPoints;
  int teamPoints;
  int tablePoints;

  factory TeamResult.fromJson(Map<String, dynamic> json) => TeamResult(
        id: json["id"],
        matchId: json["matchId"],
        teamId: json["teamId"],
        teamState: json["teamState"],
        full: json["full"],
        clean: json["clean"],
        total: json["total"],
        faults: json["faults"],
        setPoints: json["setPoints"],
        teamPoints: json["teamPoints"],
        tablePoints: json["tablePoints"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "matchId": matchId,
        "teamId": teamId,
        "teamState": teamState,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "setPoints": setPoints,
        "teamPoints": teamPoints,
        "tablePoints": tablePoints,
      };
}
