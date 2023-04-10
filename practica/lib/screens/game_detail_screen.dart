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
  Color colorMeta = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(snapshot.data!.background_image
                                    .toString() !=
                                'null'
                            ? snapshot.data!.background_image.toString()
                            : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc'),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: colorMeta,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data!.metacritic.toString() != null
                                  ? snapshot.data!.metacritic.toString()
                                  : 'https://imgs.search.brave.com/oklXnQr3XKmAt4D5nMVW-iChIPkHYc_GwB3R8JSRei4/rs:fit:720:717:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNzM2/eC8yYi8wNC8zZi8y/YjA0M2Y1ZTcwMjE3/MzQyOTFmNGJhNTc4/ZTgzOWUxYS5qcGc',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Descripcion',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      snapshot.data!.description_raw.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
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
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
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
                            return SizedBox(
                              height: 200,
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
                                        startAt: Duration(seconds: 1),
                                        looping: false,
                                        aspectRatio: 2,
                                        overlay: Container(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Text(video.name.toString())),
                                        placeholder: Center(
                                          child: Image.network(
                                              video.preview.toString()),
                                        )),
                                  );
                                },
                              ),
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
                    Text(
                      'Fecha de lanzamiento: ${snapshot.data!.released.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 192, 192, 192),
                      ),
                    ),
                    //Text(snapshot.data!.genres.toString()),
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
