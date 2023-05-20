import 'dart:convert';

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));

String countriesToJson(Countries data) => json.encode(data.toJson());

class Countries {
  Countries({
    required this.list,
  });

  List<Country> list;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        list: List<Country>.from(json["list"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.organisationName,
    required this.organisationFullName,
  });

  int id;
  String name;
  String code;
  String organisationName;
  String organisationFullName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        organisationName: json["organisationName"],
        organisationFullName: json["organisationFullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "organisationName": organisationName,
        "organisationFullName": organisationFullName,
      };
}
