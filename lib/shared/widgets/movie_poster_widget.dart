import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/core/constants/tmdb_image_config.dart';

class MoviePosterWidget extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;

  const MoviePosterWidget({
    super.key,
    required this.posterPath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (posterPath == null) {
      return SizedBox(
        width: width,
        height: height,
        child: const Center(child: Icon(Icons.movie)),
      );
    }
    return CachedNetworkImage(
      imageUrl: '${TmdbImageConfig.posterW500}$posterPath',
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Center(child: Icon(Icons.broken_image)),
      ),
    );
  }
}
