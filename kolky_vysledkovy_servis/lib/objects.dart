class Season {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  Season(this.id, this.name, this.startDate, this.endDate);

  Season.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        startDate = DateTime.parse(json['start_date']),
        endDate = DateTime.parse(json['end_date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
      };
}

class League {
  final String id;
  final String name;
  final String country;

  League(this.id, this.name, this.country);

  League.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = json['country'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
      };
}

class Tournament {
  final String id;
  final String name;
  final String type;
  final League league;

  Tournament(this.id, this.name, this.type, this.league);

  Tournament.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        league = League.fromJson(json['league']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'league': league.toJson(),
      };
}

class Player {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int number;
  final Club club;

  Player(
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.number,
    this.club,
  );

  Player.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        birthDate = DateTime.parse(json['birth_date']),
        number = json['number'],
        club = Club.fromJson(json['club']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': birthDate.toIso8601String(),
        'number': number,
        'club': club.toJson(),
      };
}

class Club {
  final String id;
  final String name;
  final String country;
  final List<Player> players;

  Club(this.id, this.name, this.country, this.players);

  Club.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = json['country'],
        players = (json['players'] as List)
            .map((playerJson) => Player.fromJson(playerJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'players': players.map((player) => player.toJson()).toList(),
      };
}

class Team {
  final String id;
  final String name;
  final Club club;
  final List<Player> players;

  Team(this.id, this.name, this.club, this.players);

  Team.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        club = Club.fromJson(json['club']),
        players = (json['players'] as List)
            .map((playerJson) => Player.fromJson(playerJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'club': club.toJson(),
        'players': players.map((player) => player.toJson()).toList(),
      };
}
