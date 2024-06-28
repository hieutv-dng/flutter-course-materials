import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutflix_tutorial/screens/index.dart';
import 'package:flutter/material.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MoviePosterCard(movie: movie);
        },
      ),
    );
  }
}
