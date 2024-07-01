import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutflix_tutorial/data/index.dart';
import 'package:flutflix_tutorial/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    super.key,
    required this.movie,
    required this.size,
  });

  final Movie movie;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movie: movie),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: movie.posterPathUrl,
          fit: BoxFit.cover,
          width: size.width,
          height: size.height,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.black12,
              child: IgnorePointer(child: Container(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }
}
