class Hall {
  Hall({
    required this.id,
    required this.name,
    required this.lanesCount,
    required this.description,
    this.parentHall,
  });

  int id;
  String name;
  int lanesCount;
  String description;
  dynamic parentHall;

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json["id"],
        name: json["name"],
        lanesCount: json["lanesCount"],
        description: json["description"],
        parentHall: json["parentHall"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lanesCount": lanesCount,
        "description": description,
        "parentHall": parentHall,
      };
}
