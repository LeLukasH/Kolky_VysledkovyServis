class Club {
  Club({
    required this.id,
    required this.name,
    required this.photo,
    required this.type,
    required this.foreignId,
  });

  int id;
  String name;
  dynamic photo;
  String type;
  int foreignId;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        type: json["type"],
        foreignId: json["foreignId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "type": type,
        "foreignId": foreignId,
      };
}
