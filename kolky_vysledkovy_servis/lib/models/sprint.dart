import 'package:kolky_vysledkovy_servis/all_models.dart';

class Sprint {
  Sprint({
    this.id,
    this.playerId,
    this.matchId,
    this.teamId,
    this.playerOrder,
    this.set1,
    this.set2,
    this.suddenVictory,
    this.point,
    this.player,
  });

  int? id;
  int? playerId;
  int? matchId;
  int? teamId;
  int? playerOrder;
  int? set1;
  int? set2;
  int? suddenVictory;
  int? point;
  Player? player;

  factory Sprint.fromJson(Map<String, dynamic> json) => Sprint(
        id: json["id"],
        playerId: json["playerId"],
        matchId: json["matchId"],
        teamId: json["teamId"],
        playerOrder: json["playerOrder"],
        set1: json["set1"],
        set2: json["set2"],
        suddenVictory: json["suddenVictory"],
        point: json["point"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "playerId": playerId,
        "matchId": matchId,
        "teamId": teamId,
        "playerOrder": playerOrder,
        "set1": set1,
        "set2": set2,
        "suddenVictory": suddenVictory,
        "point": point,
        "player": player!.toJson(),
      };
}
