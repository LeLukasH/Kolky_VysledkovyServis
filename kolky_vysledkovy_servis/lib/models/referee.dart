class Referee {
  Referee({
    required this.id,
    required this.name,
    required this.registrationId,
    required this.registrationValid,
    required this.foreignId,
  });

  int id;
  String name;
  String registrationId;
  DateTime registrationValid;
  int foreignId;

  factory Referee.fromJson(Map<String, dynamic> json) => Referee(
        id: json["id"],
        name: json["name"],
        registrationId: json["registrationId"],
        registrationValid: DateTime.parse(json["registrationValid"]),
        foreignId: json["foreignId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "registrationId": registrationId,
        "registrationValid":
            "${registrationValid.year.toString().padLeft(4, '0')}-${registrationValid.month.toString().padLeft(2, '0')}-${registrationValid.day.toString().padLeft(2, '0')}",
        "foreignId": foreignId,
      };
}
