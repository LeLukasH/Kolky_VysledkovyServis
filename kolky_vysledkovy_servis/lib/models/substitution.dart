import 'player.dart';

class Substitution {
  Substitution({
    required this.id,
    required this.matchId,
    required this.player,
    required this.newPlayer,
    required this.throwNumber,
    required this.teamState,
    required this.created,
  });

  int id;
  int matchId;
  Player player;
  Player newPlayer;
  int throwNumber;
  String teamState;
  DateTime created;

  factory Substitution.fromJson(Map<String, dynamic> json) => Substitution(
        id: json["id"],
        matchId: json["matchId"],
        player: Player.fromJson(json["player"]),
        newPlayer: Player.fromJson(json["newPlayer"]),
        throwNumber: json["throwNumber"],
        teamState: json["teamState"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "matchId": matchId,
        "player": player.toJson(),
        "newPlayer": newPlayer.toJson(),
        "throwNumber": throwNumber,
        "teamState": teamState,
        "created": created.toIso8601String(),
      };
}
