import 'package:flutter/material.dart';
import 'package:practicauno/models/games/games_model.dart';
import 'package:practicauno/network/api_popular.dart';
import 'package:practicauno/widgets/item_popular_movie.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/popular_model.dart';
import '../network/api_games.dart';
import '../provider/flags_provider.dart';
import '../widgets/item_game.dart';
import 'game_detail_screen.dart';
import 'movie_detail_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  ApiGames? apiGames;

  @override
  void initState() {
    super.initState();
    apiGames = ApiGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games Screen'),
      ),
      body: FutureBuilder(
        future: apiGames!.getAllGames(),
        builder: (context, AsyncSnapshot<List<GamesModel>?> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  GamesModel model = snapshot.data![index];
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GameDetail(model: model)));
                      },
                      child: ItemGame(gamesModel: snapshot.data![index]),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Algo salio mal :()'),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                itemCount: snapshot.data != null
                    ? snapshot.data!.length
                    : 0, //snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text(
                  'Esta muy vacio por aqui :|',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
