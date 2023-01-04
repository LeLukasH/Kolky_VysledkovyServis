import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.id,
    required this.name,
    required this.rank,
    required this.created,
    this.modified,
  });

  int id;
  String name;
  int rank;
  DateTime created;
  dynamic modified;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        rank: json["rank"],
        created: DateTime.parse(json["created"]),
        modified:
            json["modified"] != null ? DateTime.parse(json["modified"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rank": rank,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
      };
}
