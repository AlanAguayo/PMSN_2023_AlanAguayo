class GamesModel {
  int? id;
  String? name;
  String? background_image;
  int? metacritic;
  List<Genres>? genres;
  List<ParentPlatforms>? parent_platforms;

  GamesModel({
    this.id,
    this.name,
    this.background_image,
    this.metacritic,
    this.genres,
    this.parent_platforms,
  });

  factory GamesModel.fromMap(Map<String, dynamic> map) {
    var list = map['genres'] as List;
    List<Genres> genresList = list.map((i) => Genres.fromMap(i)).toList();

    list = map['parent_platforms'] as List;
    List<ParentPlatforms> platformsList =
        list.map((i) => ParentPlatforms.fromMap(i)).toList();

    return GamesModel(
      id: map['id'],
      name: map['name'],
      background_image: map['background_image'],
      metacritic: map['metacritic'],
      genres: genresList,
      parent_platforms: platformsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'background_image': background_image,
      'metacritic': metacritic,
    };
  }
}

class Genres {
  int? id;
  String? name;

  Genres({
    this.id,
    this.name,
  });

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ParentPlatforms {
  Platform? platform;

  ParentPlatforms({
    this.platform,
  });

  factory ParentPlatforms.fromMap(Map<String, dynamic> map) {
    return ParentPlatforms(platform: Platform.fromMap(map['platform']));
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
    };
  }
}

class Platform {
  int? id;
  String? name;

  Platform({
    this.id,
    this.name,
  });

  factory Platform.fromMap(Map<String, dynamic> map) {
    return Platform(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
