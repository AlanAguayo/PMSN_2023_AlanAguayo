class GamesModel {
  int? id;
  String? name;
  String? released;
  String? background_image;
  double? rating;
  int? metacritic;
  String? saturatedColor;
  String? dominantColor;

  GamesModel({
    this.id,
    this.name,
    this.released,
    this.background_image,
    this.rating,
    this.metacritic,
    this.saturatedColor,
    this.dominantColor,
  });

  factory GamesModel.fromMap(Map<String, dynamic> map) {
    return GamesModel(
      id: map['id'],
      name: map['name'],
      released: map['released'],
      background_image: map['background_image'],
      rating: map['rating'],
      metacritic: map['metacritic'],
      saturatedColor: map['saturatedColor'],
      dominantColor: map['dominantColor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'released': released,
      'background_image': background_image,
      'rating': rating,
      'metacritic': metacritic,
      'saturatedColor': saturatedColor,
      'dominantColor': dominantColor,
    };
  }
}
