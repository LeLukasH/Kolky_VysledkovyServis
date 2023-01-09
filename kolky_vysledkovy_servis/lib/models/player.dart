class Player {
  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.nameMark,
    required this.birthday,
    required this.registrationId,
    required this.registrationValid,
    required this.foreignId,
  });

  int id;
  String firstName;
  String lastName;
  dynamic nameMark;
  DateTime birthday;
  dynamic registrationId;
  DateTime registrationValid;
  int foreignId;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        nameMark: json["nameMark"],
        birthday: DateTime.parse(json["birthday"]),
        registrationId: json["registrationId"],
        registrationValid: DateTime.parse(json["registrationValid"]),
        foreignId: json["foreignId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "nameMark": nameMark,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "registrationId": registrationId,
        "registrationValid":
            "${registrationValid.year.toString().padLeft(4, '0')}-${registrationValid.month.toString().padLeft(2, '0')}-${registrationValid.day.toString().padLeft(2, '0')}",
        "foreignId": foreignId,
      };
}
