class CharactersModel {
  final String id;
  final String name;
  final Map<String, dynamic> powerstats;
  final String fullName;
  final List aliases;
  final String image;

  CharactersModel({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.fullName,
    required this.aliases,
    required this.image,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'],
      name: json['name'],
      powerstats: json['powerstats'],
      fullName: json['biography']['full-name'],
      aliases: json['biography']['aliases'],
      image: json['image']['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'powerstats': powerstats,
      'full-name': fullName,
      'aliases': aliases,
      'url': image,
    };
  }
}

class TopSuperHero {
  final String id;
  final String name;
  final Map<String, dynamic> powerstats;
  final String fullName;
  final List aliases;
  final String image;

  TopSuperHero({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.fullName,
    required this.aliases,
    required this.image,
  });

  factory TopSuperHero.fromJson(Map<String, dynamic> json) {
    return TopSuperHero(
      id: json['id'],
      name: json['name'],
      powerstats: json['powerstats'],
      fullName: json['biography']['full-name'],
      aliases: json['biography']['aliases'],
      image: json['image']['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'powerstats': powerstats,
      'full-name': fullName,
      'aliases': aliases,
      'url': image,
    };
  }
}
