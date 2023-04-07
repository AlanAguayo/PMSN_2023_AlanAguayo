import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicauno/models/popular_model.dart';

import '../models/actor_model.dart';

class ApiPopular {
  Future<List<PopularModel>?> getAllPopular() async {
    final URL =
        "https://api.themoviedb.org/3/movie/popular?api_key=fee8a8099c56235ef6fce1d7bae09197&language=es-MX&page=1";
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular =
          popular.map((video) => PopularModel.fromMap(video)).toList();
      return listPopular;
    }
    return null;
  }

  Future<String> getVideo(int id) async {
    final URL =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=fee8a8099c56235ef6fce1d7bae09197';
    final response = await http.get(Uri.parse(URL));
    var listVideo = jsonDecode(response.body)['results'] as List;
    if (response.statusCode == 200) {
      listVideo = jsonDecode(response.body)['results'] as List;
    }
    for (var element in listVideo) {
      if (element['type'] == 'Trailer') {
        return element['key'];
      }
    }
    return '';
  }

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async {
    final URL =
        'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=fee8a8099c56235ef6fce1d7bae09197';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var listActor = jsonDecode(response.body)['cast'] as List;
      return listActor.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}
