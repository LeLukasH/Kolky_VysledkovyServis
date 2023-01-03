class Hall {
  Hall({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.lanesCount,
    required this.description,
    this.parentHall,
  });

  int id;
  String name;
  String address;
  String lat;
  String lng;
  int lanesCount;
  String description;
  dynamic parentHall;

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        lanesCount: json["lanesCount"],
        description: json["description"],
        parentHall: json["parentHall"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "lat": lat,
        "lng": lng,
        "lanesCount": lanesCount,
        "description": description,
        "parentHall": parentHall,
      };
}
