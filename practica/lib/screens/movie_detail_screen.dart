import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../database/database_helper.dart';
import '../models/actor_model.dart';
import '../models/popular_model.dart';
import '../network/api_popular.dart';
import '../provider/flags_provider.dart';
import '../widgets/item_actor_popular.dart';

class MovieDetail extends StatefulWidget {
  final PopularModel model;
  MovieDetail({Key? key, required this.model}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final ApiPopular apiPopular = ApiPopular();

  final DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        actions: [
          FutureBuilder(
            future: helper.GETPOPULAR(widget.model.id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (snapshot.data!.isEmpty) {
                        helper
                            .INSERTAR('tblPopular', widget.model.toMap())
                            .then(
                          (value) {
                            flag.setUpdate();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Se agrego a favoritos')));
                          },
                        );
                      } else {
                        helper
                            .ELIMINAR('tblPopular', widget.model.id!, 'id')
                            .then((value) {
                          flag.setUpdate();
                          var msj = value > 0
                              ? 'Se quito de favoritos'
                              : 'ocurrio un error';

                          var snackBar = SnackBar(content: Text(msj));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: Icon(
                      snapshot.data!.isEmpty
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          /////
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${widget.model.backdropPath}'),
                      fit: BoxFit.fitHeight,
                      opacity: 0.3)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.model.title.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: apiPopular.getVideo(widget.model.id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return YoutubePlayer(
                            controller: YoutubePlayerController(
                                initialVideoId: snapshot.data.toString(),
                                flags: const YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: true,
                                  captionLanguage: AutofillHints.countryName,
                                )),
                          );
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
                    const Text(
                      'Sinopsis',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.model.overview.toString(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Rating',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    RatingBar(
                      initialRating: widget.model.voteAverage! / 2,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: Color.fromARGB(255, 255, 238, 0)),
                          half: const Icon(
                            Icons.star_half,
                            color: Color.fromARGB(255, 255, 238, 0),
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Color.fromARGB(255, 255, 238, 0),
                          )),
                      ignoreGestures: true,
                      onRatingUpdate: (value) {},
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Actores',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<ActorModel>?>(
                      future: apiPopular.getAllActors(widget.model),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                ActorModel actor = snapshot.data![index];
                                return CardActor(
                                  name: actor.name.toString(),
                                  photo: actor.profilePath != null
                                      ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                      : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                                  character: actor.character!,
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget informacion() {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar(
                  initialRating: widget.model.voteAverage! / 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star,
                          color: Color.fromARGB(255, 255, 238, 0)),
                      half: const Icon(
                        Icons.star_half,
                        color: Color.fromARGB(255, 255, 238, 0),
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Color.fromARGB(255, 255, 238, 0),
                      )),
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            const Text(
              'Sinopsis',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              widget.model.overview.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 40),
            const Text(
              'Actores',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<ActorModel>?>(
              future: apiPopular.getAllActors(widget.model),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ActorModel actor = snapshot.data![index];
                        return CardActor(
                          name: actor.name.toString(),
                          photo: actor.profilePath != null
                              ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                              : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                          character: actor.character!,
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }

  Widget botonera(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
              future: helper.GETPOPULAR(widget.model.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      if (snapshot.data != true) {
                        helper
                            .INSERTAR('tblPopular', widget.model.toMap())
                            .then((value) {
                          flag.setUpdate();
                          var msj = value > 0
                              ? 'Se agrego a favoritos'
                              : 'ocurrio un error';

                          var snackBar = SnackBar(content: Text(msj));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      } else {
                        helper
                            .ELIMINAR(
                                'tblPopularFav', widget.model.id!, 'idPopular')
                            .then((value) {
                          flag.setUpdate();
                          var msj = value > 0
                              ? 'Se quito de favoritos'
                              : 'ocurrio un error';

                          var snackBar = SnackBar(content: Text(msj));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          color:
                              snapshot.data != true ? Colors.white : Colors.red,
                        ),
                        const Text(
                          'Añadir a favoritos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
