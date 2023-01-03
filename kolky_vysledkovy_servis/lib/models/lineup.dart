import 'lane.dart';
import 'player.dart';

class LineUps {
  LineUps({
    required this.home,
    required this.away,
  });

  List<LineUp> home;
  List<LineUp> away;

  factory LineUps.fromJson(Map<String, dynamic> json) => LineUps(
        home: List<LineUp>.from(json["home"].map((x) => LineUp.fromJson(x))),
        away: List<LineUp>.from(json["away"].map((x) => LineUp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home": List<dynamic>.from(home.map((x) => x.toJson())),
        "away": List<dynamic>.from(away.map((x) => x.toJson())),
      };
}

class LineUp {
  LineUp({
    required this.id,
    required this.matchId,
    this.tournamentId,
    this.tournamentRoundId,
    required this.teamId,
    this.clubId,
    required this.playerOrder,
    required this.changeThrow,
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
    required this.lanes,
  });

  int id;
  int matchId;
  dynamic tournamentId;
  dynamic tournamentRoundId;
  int teamId;
  dynamic clubId;
  int playerOrder;
  int changeThrow;
  dynamic throwsCount;
  int full;
  int clean;
  int total;
  int faults;
  int setPoints;
  int points;
  dynamic suddenVictory;
  Player player;
  dynamic otherPlayer;
  dynamic specialName;
  DateTime created;
  List<Lane> lanes;

  factory LineUp.fromJson(Map<String, dynamic> json) => LineUp(
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
        lanes: List<Lane>.from(json["lanes"].map((x) => Lane.fromJson(x))),
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
        "lanes": List<dynamic>.from(lanes.map((x) => x.toJson())),
      };
}
