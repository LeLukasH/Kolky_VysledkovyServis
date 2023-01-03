class Lane {
  Lane({
    required this.id,
    this.lane,
    required this.full,
    required this.clean,
    required this.total,
    required this.faults,
    required this.points,
  });

  int id;
  dynamic lane;
  int full;
  int clean;
  int total;
  int faults;
  int points;

  factory Lane.fromJson(Map<String, dynamic> json) => Lane(
        id: json["id"],
        lane: json["lane"],
        full: json["full"],
        clean: json["clean"],
        total: json["total"],
        faults: json["faults"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lane": lane,
        "full": full,
        "clean": clean,
        "total": total,
        "faults": faults,
        "points": points,
      };
}
