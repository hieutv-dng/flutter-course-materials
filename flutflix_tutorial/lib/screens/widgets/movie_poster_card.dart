import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutter/material.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Image.network(movie.posterPathUrl),
    );
  }
}
