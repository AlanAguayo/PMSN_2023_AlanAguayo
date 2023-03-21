import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicauno/models/popular_model.dart';

class ApiPopular {
  final URL =
      "https://api.themoviedb.org/3/movie/popular?api_key=fee8a8099c56235ef6fce1d7bae09197&language=es-MX&page=1";

  Future<List<PopularModel>?> getAllPopular() async {
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular =
          popular.map((video) => PopularModel.fromMap(video)).toList();
      return listPopular;
    }
    return null;
  }
}
