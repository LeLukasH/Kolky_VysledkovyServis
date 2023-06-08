import 'dart:convert';

Seasons seasonsFromJson(String str) => Seasons.fromJson(json.decode(str));

String seasonsToJson(Seasons data) => json.encode(data.toJson());

class Seasons {
  Seasons({
    required this.list,
  });

  List<Season> list;

  factory Seasons.fromJson(Map<String, dynamic> json) => Seasons(
        list: List<Season>.from(json["list"].map((x) => Season.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Season {
  Season({
    required this.id,
    required this.name,
    required this.dateFrom,
    required this.dateTo,
  });

  int id;
  String name;
  DateTime dateFrom;
  DateTime dateTo;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        name: json["name"],
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dateFrom":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "dateTo":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
      };
}

class SeasonFields {
  static const String tableSeason = 'seasons';

  static const String id = 'id';
  static const String name = 'name';
  static const String dateFrom = 'dateFrom';
  static const String dateTo = 'dateTo';

  static const List<String> values = [
    id,
    name,
    dateFrom,
    dateTo,
  ];

  static String createTableQuery = '''
      CREATE TABLE $tableSeason (
        $id INTEGER PRIMARY KEY,
        $name TEXT,
        $dateFrom TEXT,
        $dateTo TEXT
      )
    ''';
}
