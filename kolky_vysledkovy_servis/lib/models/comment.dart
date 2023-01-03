// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

import 'createdby.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.created,
    required this.modified,
    required this.content,
    required this.leagueId,
    required this.round,
    required this.createdBy,
  });

  int id;
  DateTime created;
  dynamic modified;
  String content;
  int leagueId;
  int round;
  CreatedBy createdBy;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        modified: json["modified"],
        content: json["content"],
        leagueId: json["leagueId"],
        round: json["round"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "modified": modified,
        "content": content,
        "leagueId": leagueId,
        "round": round,
        "createdBy": createdBy.toJson(),
      };
}
