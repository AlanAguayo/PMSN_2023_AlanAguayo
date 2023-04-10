import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/games/detail_model.dart';
import '../models/games/games_model.dart';
import '../models/games/screenshot_model.dart';
import '../models/games/video_model.dart';

class ApiGames {
  Future<List<GamesModel>?> getAllGames(
      String pageSize, String search, String ordering) async {
    final URL =
        'https://api.rawg.io/api/games?key=07e8df81224a44f2ba07c34720b43229&page_size=${pageSize}&search=${search}&ordering=${ordering}';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var games = jsonDecode(response.body)['results'] as List;
      var listGames = games.map((game) => GamesModel.fromMap(game)).toList();
      return listGames;
    }
    return null;
  }

  Future<DetailModel> getGameDetail(String id) async {
    final URL =
        'https://api.rawg.io/api/games/${id}?key=07e8df81224a44f2ba07c34720b43229';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return DetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Hubo un error :()');
    }
  }

  Future<List<ScreenshotModel>?> getGameImage(String id) async {
    final URL =
        'https://api.rawg.io/api/games/${id}/screenshots?key=07e8df81224a44f2ba07c34720b43229';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var screenshot = jsonDecode(response.body)['results'] as List;
      var listGames =
          screenshot.map((game) => ScreenshotModel.fromMap(game)).toList();
      return listGames;
    }
    return null;
  }

  Future<List<VideoModel>?> getGameVideo(String id) async {
    final URL =
        'https://api.rawg.io/api/games/${id}/movies?key=07e8df81224a44f2ba07c34720b43229';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var video = jsonDecode(response.body)['results'] as List;
      var listGames = video.map((game) => VideoModel.fromMap(game)).toList();
      return listGames;
    }
    return null;
  }
}
