class DetailModel {
  int? id;
  String? name;
  String? description_raw;
  int? metacritic;
  String? released;
  String? background_image;
  String? background_image_additional;
  List<Genres>? genres;
  List<Ratings>? ratings;
  List<Tags>? tags;
  List<Publishers>? publishers;
  List<Developers>? developers;
  ESRB? esrb_rating;
  List<Platforms>? platforms;

  DetailModel(
      {this.id,
      this.name,
      this.description_raw,
      this.metacritic,
      this.released,
      this.background_image,
      this.background_image_additional,
      this.genres,
      this.ratings,
      this.tags,
      this.publishers,
      this.developers,
      this.esrb_rating,
      this.platforms});

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    var list = json['genres'] as List;
    List<Genres> genresList = list.map((i) => Genres.fromMap(i)).toList();

    list = json['ratings'] as List;
    List<Ratings> ratingsList = list.map((i) => Ratings.fromMap(i)).toList();

    list = json['tags'] as List;
    List<Tags> tagsList = list.map((i) => Tags.fromMap(i)).toList();

    list = json['developers'] as List;
    List<Developers> developersList =
        list.map((i) => Developers.fromMap(i)).toList();

    list = json['publishers'] as List;
    List<Publishers> publishersList =
        list.map((i) => Publishers.fromMap(i)).toList();

    list = json['platforms'] as List;
    List<Platforms> platformsList =
        list.map((i) => Platforms.fromMap(i)).toList();

    return DetailModel(
        id: json['id'],
        name: json['name'],
        description_raw: json['description_raw'],
        metacritic: json['metacritic'],
        released: json['released'],
        background_image: json['background_image'],
        background_image_additional: json['background_image_additional'],
        genres: genresList,
        ratings: ratingsList,
        tags: tagsList,
        developers: developersList,
        publishers: publishersList,
        esrb_rating: ESRB.fromMap(json['esrb_rating']),
        platforms: platformsList);
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

class Ratings {
  int? id;
  String? title;
  double? percent;

  Ratings({
    this.id,
    this.title,
    this.percent,
  });

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(id: map['id'], title: map['title'], percent: map['percent']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'percent': percent,
    };
  }
}

class Tags {
  int? id;
  String? name;

  Tags({
    this.id,
    this.name,
  });

  factory Tags.fromMap(Map<String, dynamic> map) {
    return Tags(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Publishers {
  int? id;
  String? name;

  Publishers({
    this.id,
    this.name,
  });

  factory Publishers.fromMap(Map<String, dynamic> map) {
    return Publishers(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Developers {
  int? id;
  String? name;

  Developers({
    this.id,
    this.name,
  });

  factory Developers.fromMap(Map<String, dynamic> map) {
    return Developers(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ESRB {
  int? id;
  String? name;

  ESRB({
    this.id,
    this.name,
  });

  factory ESRB.fromMap(Map<String, dynamic> map) {
    return ESRB(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Platforms {
  Platform? platform;

  Platforms({
    this.platform,
  });

  factory Platforms.fromMap(Map<String, dynamic> map) {
    return Platforms(platform: Platform.fromMap(map['platform']));
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
