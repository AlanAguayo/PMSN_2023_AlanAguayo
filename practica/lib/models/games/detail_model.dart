class DetailModel {
  int? id;
  String? name;
  String? description_raw;
  int? metacritic;
  String? released;
  String? background_image;
  String? background_image_additional;

  DetailModel({
    this.id,
    this.name,
    this.description_raw,
    this.metacritic,
    this.released,
    this.background_image,
    this.background_image_additional,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'],
      name: json['name'],
      description_raw: json['description_raw'],
      metacritic: json['metacritic'],
      released: json['released'],
      background_image: json['background_image'],
      background_image_additional: json['background_image_additional'],
    );
  }
}
