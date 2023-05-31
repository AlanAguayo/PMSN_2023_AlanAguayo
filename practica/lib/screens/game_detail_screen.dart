import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/network/api_games.dart';
import 'package:video_player/video_player.dart';

import '../models/games/detail_model.dart';
import '../models/games/screenshot_model.dart';
import '../models/games/video_model.dart';

class GameDetail extends StatefulWidget {
  final String id;
  GameDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  final ApiGames apiGames = ApiGames();
  late Future<DetailModel> gameDetail = apiGames.getGameDetail(widget.id);
  Color colorMeta = Color.fromARGB(255, 1, 197, 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DetailModel>(
          future: gameDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.metacritic.toString() != 'null') {
                if (snapshot.data!.metacritic!.toInt() < 33) {
                  colorMeta = const Color.fromARGB(255, 190, 0, 0);
                } else if (snapshot.data!.metacritic!.toInt() < 66) {
                  colorMeta = const Color.fromARGB(255, 227, 231, 0);
                }
              } else {
                colorMeta = const Color.fromARGB(255, 50, 50, 50);
              }
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(snapshot
                                  .data!.background_image_additional
                                  .toString() !=
                              'null'
                          ? snapshot.data!.background_image_additional
                              .toString()
                          : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc'),
                      opacity: 0.2,
                      fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    Text(
                      snapshot.data!.name.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    snapshot.data!.esrb_rating != null
                        ? Text(
                            'Clasificacion: ${snapshot.data!.esrb_rating!.name.toString()}')
                        : const Text('Sin clasificacion'),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.publishers!.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.publishers![
                                    snapshot.data!.publishers!.length - 1] !=
                                snapshot.data!.publishers![index]) {
                              return Text(
                                  '${snapshot.data!.publishers![index].name.toString()} - ');
                            } else {
                              return Text(
                                  '${snapshot.data!.publishers![index].name.toString()}');
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(
                          snapshot.data!.background_image.toString() != 'null'
                              ? snapshot.data!.background_image.toString()
                              : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc',
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: colorMeta,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Center(
                                child: Text(
                                  // ignore: unnecessary_null_comparison, prefer_if_null_operators
                                  snapshot.data!.metacritic.toString() != null
                                      ? snapshot.data!.metacritic.toString()
                                      : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(230, 255, 255, 255),
                                  ),
                                ),
                              ),
                              const Text(
                                'Metacritics',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(230, 255, 255, 255)),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 20,
                      child: ListView.builder(
                          itemCount: snapshot.data!.genres!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Text(
                              '${snapshot.data!.genres![index].name.toString()}   ',
                              style: const TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Opinion de la comunidad',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.ratings!.length,
                          itemBuilder: (context, index) {
                            var ratingEmoji = '';
                            var ratingColor = [
                              const Color.fromARGB(255, 92, 92, 92),
                              const Color.fromARGB(255, 92, 92, 92)
                            ];
                            switch (
                                snapshot.data!.ratings![index].id.toString()) {
                              case '5':
                                ratingEmoji = '😄';
                                ratingColor = [
                                  Color.fromARGB(255, 29, 252, 0),
                                  Color.fromARGB(255, 0, 141, 0)
                                ];
                                break;
                              case '4':
                                ratingEmoji = '🙂';
                                ratingColor = [
                                  const Color.fromARGB(255, 0, 120, 189),
                                  const Color.fromARGB(255, 0, 86, 136)
                                ];
                                break;
                              case '3':
                                ratingEmoji = '😕';
                                ratingColor = [
                                  Color.fromARGB(255, 160, 91, 0),
                                  Color.fromARGB(255, 223, 126, 0)
                                ];
                                break;
                              case '1':
                                ratingEmoji = '😴';

                                ratingColor = [
                                  Color.fromARGB(255, 117, 0, 0),
                                  Color.fromARGB(255, 233, 0, 0)
                                ];
                                break;
                              default:
                                ratingEmoji = '';
                                ratingColor = [
                                  const Color.fromARGB(255, 92, 92, 92),
                                  const Color.fromARGB(255, 92, 92, 92)
                                ];
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    transform: const GradientRotation(80),
                                    colors: ratingColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  border: Border.all(width: 1)),
                              padding: const EdgeInsets.all(5),
                              width: (MediaQuery.of(context).size.width / 4),
                              child: Column(
                                children: [
                                  Text(ratingEmoji),
                                  Text(
                                    snapshot.data!.ratings![index].title
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      '${snapshot.data!.ratings![index].percent.toString()}%',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Descripcion',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      snapshot.data!.description_raw.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<List<ScreenshotModel>?>(
                      future: apiGames.getGameImage(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.isNotEmpty) {
                            return Column(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Screenshots',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      ScreenshotModel screenshot =
                                          snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0, top: 8),
                                        child: Image.network(
                                            screenshot.image.toString()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<List<VideoModel>?>(
                      future: apiGames.getGameVideo(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.isNotEmpty) {
                            return Column(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Trailers',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 230,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      VideoModel video = snapshot.data![index];
                                      return Chewie(
                                        controller: ChewieController(
                                          allowMuting: true,
                                          allowFullScreen: false,
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  video.data!.max.toString()),
                                          autoPlay: false,
                                          looping: false,
                                          aspectRatio: 2,
                                          overlay: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child:
                                                  Text(video.name.toString())),
                                          placeholder: Center(
                                            child: Image.network(
                                                video.preview.toString()),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Fecha de lanzamiento: ${snapshot.data!.released.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 192, 192, 192),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                        color: Color.fromARGB(176, 139, 139, 139),
                        height: 2,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1.5),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Tags',
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 236, 236),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 100,
                      child: GridView.builder(
                        itemCount: snapshot.data!.tags!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            snapshot.data!.tags![index].name.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 192, 192, 192),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                        color: Color.fromARGB(176, 139, 139, 139),
                        height: 2,
                        indent: 10,
                        endIndent: 20,
                        thickness: 1.5),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Desarrolladores',
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 236, 236),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 25,
                      child: GridView.builder(
                        itemCount: snapshot.data!.developers!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            snapshot.data!.developers![index].name.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 192, 192, 192),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                        color: Color.fromARGB(176, 139, 139, 139),
                        height: 2,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1.5),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Plataformas',
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 236, 236),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: GridView.builder(
                        itemCount: snapshot.data!.platforms!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            snapshot.data!.platforms![index].platform!.name
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 192, 192, 192),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 20),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              const Center(
                child: Text('Hubo un error ;()'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
