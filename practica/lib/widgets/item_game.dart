import 'package:flutter/material.dart';
import 'package:practicauno/models/popular_model.dart';

import '../models/games/games_model.dart';

class ItemGame extends StatelessWidget {
  ItemGame({super.key, required this.gamesModel});

  final GamesModel gamesModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/Loading.gif'),
      image: NetworkImage(gamesModel.background_image.toString()),
    );
  }
}
