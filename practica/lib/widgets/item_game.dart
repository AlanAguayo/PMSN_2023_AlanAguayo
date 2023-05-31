import 'package:flutter/material.dart';
import '../models/games/games_model.dart';

class ItemGame extends StatelessWidget {
  const ItemGame({super.key, required this.gamesModel});

  final GamesModel gamesModel;

  emoji(calf) {
    var icono = '👍';
    if (calf != null && calf != '' && calf != 'null') {
      if (double.parse(calf) < 33) {
        icono = '👎';
      } else if (double.parse(calf) < 66) {
        icono = '😐';
      }
      return icono;
    } else {
      return '';
    }
  }

  logo(id) {
    var platform = '';
    switch (id) {
      case '1':
        platform = 'assets/logoWindows.png';
        break;
      case '2':
        platform = 'assets/logoPS.png';
        break;
      case '3':
        platform = 'assets/logoXbox.png';
        break;
      case '5':
        platform = 'assets/logoApple.png';
        break;
      case '4':
        platform = 'assets/logoApple.png';
        break;
      case '6':
        platform = 'assets/logoLinux.png';
        break;
      case '7':
        platform = 'assets/logoNintendo.png';
        break;
      case '8':
        platform = 'assets/logoAndroid.png';
        break;
      default:
        platform = 'NA';
        break;
    }
    return platform;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 390,
          height: 220,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(gamesModel.background_image.toString() !=
                          'null' ||
                      // ignore: unnecessary_null_comparison
                      gamesModel.background_image.toString() == null
                  ? gamesModel.background_image.toString()
                  : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc'),
            ),
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 61, 61, 61),
          ),
        ),
        Column(
          children: [
            Container(
              height: 180,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              child: Container(
                color: const Color.fromARGB(255, 49, 49, 49),
                width: 390,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: gamesModel.parent_platforms!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                logo(gamesModel.parent_platforms![index]
                                            .platform!.id
                                            .toString()) !=
                                        'NA'
                                    ? Image.asset(
                                        logo(gamesModel.parent_platforms![index]
                                            .platform!.id
                                            .toString()),
                                        height: 15,
                                        width: 15,
                                      )
                                    : Text(gamesModel
                                        .parent_platforms![index].platform!.name
                                        .toString()),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                          '${gamesModel.name}  ${emoji(gamesModel.metacritic.toString())}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 16,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gamesModel.genres!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                '${gamesModel.genres![index].name.toString()}   ',
                                style: const TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 11,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
