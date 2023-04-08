class ScreenshotModel {
  int? id;
  String? image;
  int? width;
  int? height;

  ScreenshotModel({
    this.id,
    this.image,
    this.width,
    this.height,
  });

  factory ScreenshotModel.fromMap(Map<String, dynamic> map) {
    return ScreenshotModel(
      id: map['id'],
      image: map['image'],
      width: map['width'],
      height: map['height'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'width': width,
      'height': height,
    };
  }
}
