import 'dart:convert';

import 'club.dart';
import 'player.dart';
import 'season.dart';
import 'tournament_detail.dart';

PlayerDetail playerDetailFromJson(String str) =>
    PlayerDetail.fromJson(json.decode(str));

String playerDetailToJson(PlayerDetail data) => json.encode(data.toJson());

class PlayerDetail {
  final Player player;
  final List<PlayedClub> playedClubs;
  final List<Result> results;

  PlayerDetail({
    required this.player,
    required this.playedClubs,
    required this.results,
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) => PlayerDetail(
        player: Player.fromJson(json["player"]),
        playedClubs: List<PlayedClub>.from(
            json["playedClubs"].map((x) => PlayedClub.fromJson(x))),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "player": player.toJson(),
        "playedClubs": List<dynamic>.from(playedClubs.map((x) => x.toJson())),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PlayedClub {
  final Club club;
  final Season season;

  PlayedClub({
    required this.club,
    required this.season,
  });

  factory PlayedClub.fromJson(Map<String, dynamic> json) => PlayedClub(
        club: Club.fromJson(json["club"]),
        season: Season.fromJson(json["season"]),
      );

  Map<String, dynamic> toJson() => {
        "club": club.toJson(),
        "season": season.toJson(),
      };
}
