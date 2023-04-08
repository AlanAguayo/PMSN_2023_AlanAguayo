class VideoModel {
  int? id;
  String? name;
  String? preview;
  Map<String, String>? data;

  VideoModel({
    this.id,
    this.name,
    this.preview,
    this.data,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      name: map['name'],
      preview: map['preview'],
      data: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'preview': preview,
      'data': data,
    };
  }
}
