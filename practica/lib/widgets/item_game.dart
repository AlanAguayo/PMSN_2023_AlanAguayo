import 'package:flutter/material.dart';
import '../models/games/games_model.dart';

class ItemGame extends StatelessWidget {
  const ItemGame({super.key, required this.gamesModel});

  final GamesModel gamesModel;

  emoji(calf) {
    var icono = '👍';
    if (calf != null && calf != '' && calf != 'null') {
      if (double.parse(calf) < 33) {
        icono = '😐';
      } else if (double.parse(calf) < 66) {
        icono = '👎';
      }
      return icono;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 61, 61, 61),
      ),
      child: Column(
        children: [
          FadeInImage(
            fit: BoxFit.fill,
            placeholder: const AssetImage('assets/Loading.gif'),
            image: NetworkImage(gamesModel.background_image.toString() !=
                        'null' ||
                    gamesModel.background_image.toString() == null
                ? gamesModel.background_image.toString()
                : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc'),
            height: 180,
            width: MediaQuery.of(context).size.width / 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                    '${gamesModel.name}  ${emoji(gamesModel.metacritic.toString())}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Fecha de lanzamiento: ${gamesModel.released.toString()}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
