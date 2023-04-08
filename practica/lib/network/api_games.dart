import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/games/games_model.dart';

class ApiGames {
  Future<List<GamesModel>?> getAllGames() async {
    final URL =
        'https://api.rawg.io/api/games?key=07e8df81224a44f2ba07c34720b43229';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var games = jsonDecode(response.body)['results'] as List;
      var listGames = games.map((game) => GamesModel.fromMap(game)).toList();
      return listGames;
    }
    return null;
  }
}
