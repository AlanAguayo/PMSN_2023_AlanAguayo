import 'package:flutter/material.dart';
import 'package:practicauno/models/popular_model.dart';

class ItemPopularMovie extends StatelessWidget {
  const ItemPopularMovie({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/Loading.gif'),
      image: NetworkImage(
          'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}
