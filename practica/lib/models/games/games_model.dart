class GamesModel {
  int? id;
  String? name;
  String? released;
  String? background_image;
  int? metacritic;

  GamesModel({
    this.id,
    this.name,
    this.released,
    this.background_image,
    this.metacritic,
  });

  factory GamesModel.fromMap(Map<String, dynamic> map) {
    return GamesModel(
      id: map['id'],
      name: map['name'],
      released: map['released'],
      background_image: map['background_image'],
      metacritic: map['metacritic'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'released': released,
      'background_image': background_image,
      'metacritic': metacritic,
    };
  }
}
