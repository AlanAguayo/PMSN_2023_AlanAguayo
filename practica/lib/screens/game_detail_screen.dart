import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:practicauno/models/games/games_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../database/database_helper.dart';
import '../models/actor_model.dart';
import '../models/popular_model.dart';
import '../network/api_popular.dart';
import '../provider/flags_provider.dart';
import '../widgets/item_actor_popular.dart';

class GameDetail extends StatefulWidget {
  final GamesModel model;
  GameDetail({Key? key, required this.model}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  final ApiPopular apiPopular = ApiPopular();

  final DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Container(),
    );
  }
}
