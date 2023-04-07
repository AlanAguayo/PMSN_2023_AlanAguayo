import 'package:flutter/material.dart';
import 'package:practicauno/network/api_popular.dart';
import 'package:practicauno/widgets/item_popular_movie.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/popular_model.dart';
import '../provider/flags_provider.dart';
import 'movie_detail_screen.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  ApiPopular? apiPopular;
  int favorites = 0;
  DatabaseHelper? database;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: favorites == 0
            ? const Text('List Popular')
            : const Text('Favorite Movies'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (favorites == 1) {
                    favorites = 0;
                  } else {
                    favorites = 1;
                  }
                });
              },
              icon: favorites == 1
                  ? const Icon(
                      Icons.list,
                    )
                  : const Icon(
                      Icons.favorite,
                    ))
        ],
      ),
      body: FutureBuilder(
        future: flag.getUpdate() == true
            ? favorites == 0
                ? database!.GETALLPOPULAR()
                : apiPopular!.getAllPopular()
            : favorites == 1
                ? database!.GETALLPOPULAR()
                : apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  PopularModel model = snapshot.data![index];
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovieDetail(model: model)));
                      },
                      child:
                          ItemPopularMovie(popularModel: snapshot.data![index]),
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
              ));
            }
          }
          return Container();
        },
      ),
    );
  }
}
