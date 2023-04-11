import 'package:flutter/material.dart';
import 'package:practicauno/models/games/games_model.dart';
import '../network/api_games.dart';
import '../widgets/item_game.dart';
import 'game_detail_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  ApiGames? apiGames;
  Icon icono = const Icon(Icons.search);
  Widget customSearchBar = const Text('API Games');
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiGames = ApiGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (icono.icon == Icons.search) {
                  icono = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                    title: TextField(
                      controller: searchController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintText: 'Busca por nombre',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  );
                } else {
                  icono = const Icon(Icons.search);
                  searchController.text = '';
                  customSearchBar = const Text('API Games');
                }
              });
            },
            icon: icono,
          )
        ],
      ),
      body: searchController.text == ''
          ? ListView(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        'Populares',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                WidgetItemGame('20', '', ''),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        'Mejores Calificados',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                WidgetItemGame('20', '', '-metacritic'),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        'Actualizaciones',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                WidgetItemGame('20', '', '-updated'),
              ],
            )
          : FutureBuilder(
              future: apiGames!.getAllGames('20', searchController.text, ''),
              builder: (context, AsyncSnapshot<List<GamesModel>?> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      GamesModel model = snapshot.data![index];
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GameDetail(id: model.id.toString())));
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
                  );
                }
                return Container();
              },
            ),
    );
  }

  FutureBuilder<List<GamesModel>?> WidgetItemGame(
    String pageSize,
    String search,
    String ordering,
  ) {
    return FutureBuilder(
      future: apiGames!.getAllGames(pageSize, search, ordering),
      builder: (context, AsyncSnapshot<List<GamesModel>?> snapshot) {
        if (snapshot.data != null) {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                GamesModel model = snapshot.data![index];
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GameDetail(id: model.id.toString())));
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
            ),
          );
        }
        return Container();
      },
    );
  }
}
