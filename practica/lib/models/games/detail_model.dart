class DetailModel {
  int? id;
  String? name;
  String? description;
  int? metacritic;
  String? released;
  String? backgroundImage;
  String? backgroundImageAdditional;
  String? website;
  double? rating;
  Map<String, int>? reactions;
  String? saturatedColor;
  String? dominantColor;

  DetailModel({
    this.id,
    this.name,
    this.description,
    this.metacritic,
    this.released,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.rating,
    this.reactions,
    this.saturatedColor,
    this.dominantColor,
  });

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      metacritic: map['metacritic'],
      released: map['released'],
      backgroundImage: map['backgroundImage'],
      backgroundImageAdditional: map['backgroundImageAdditional'],
      rating: map['rating'],
      reactions: map['reactions'],
      saturatedColor: map['saturatedColor'],
      dominantColor: map['dominantColor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'metacritic': metacritic,
      'released': released,
      'backgroundImage': backgroundImage,
      'backgroundImageAdditional': backgroundImageAdditional,
      'rating': rating,
      'reactions': reactions,
      'saturatedColor': saturatedColor,
      'dominantColor': dominantColor,
    };
  }
}
