class Referee {
  Referee({
    required this.id,
    required this.name,
    required this.registrationValid,
    required this.foreignId,
  });

  int id;
  String name;
  DateTime registrationValid;
  int foreignId;

  factory Referee.fromJson(Map<String, dynamic> json) => Referee(
        id: json["id"],
        name: json["name"],
        registrationValid: DateTime.parse(json["registrationValid"]),
        foreignId: json["foreignId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "registrationValid":
            "${registrationValid.year.toString().padLeft(4, '0')}-${registrationValid.month.toString().padLeft(2, '0')}-${registrationValid.day.toString().padLeft(2, '0')}",
        "foreignId": foreignId,
      };
}
