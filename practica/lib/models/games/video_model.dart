class VideoModel {
  int? id;
  String? name;
  String? preview;
  Data? data;

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
      data: Data.fromMap(map['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'data': data, 'preview': preview};
  }
}

class Data {
  String? cuatro;
  String? max;

  Data({
    this.cuatro,
    this.max,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      cuatro: map['480'],
      max: map['max'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '480': cuatro,
      'max': max,
    };
  }
}
