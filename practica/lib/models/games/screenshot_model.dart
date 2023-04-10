class ScreenshotModel {
  int? id;
  String? image;

  ScreenshotModel({
    this.id,
    this.image,
  });

  factory ScreenshotModel.fromMap(Map<String, dynamic> map) {
    return ScreenshotModel(
      id: map['id'],
      image: map['image'],
    );
  }
}
