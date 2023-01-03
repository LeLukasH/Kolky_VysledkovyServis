import 'club.dart';
import 'country.dart';

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.lastActivity,
    required this.registered,
    required this.countryId,
    required this.active,
    required this.club,
    required this.country,
  });

  int id;
  String name;
  String email;
  String role;
  DateTime lastActivity;
  DateTime registered;
  int countryId;
  bool active;
  Club club;
  Country country;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        lastActivity: DateTime.parse(json["lastActivity"]),
        registered: DateTime.parse(json["registered"]),
        countryId: json["countryId"],
        active: json["active"],
        club: Club.fromJson(json["club"]),
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "lastActivity": lastActivity.toIso8601String(),
        "registered": registered.toIso8601String(),
        "countryId": countryId,
        "active": active,
        "club": club.toJson(),
        "country": country.toJson(),
      };
}
