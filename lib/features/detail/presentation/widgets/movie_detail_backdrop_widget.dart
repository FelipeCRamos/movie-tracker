import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/core/constants/tmdb_image_config.dart';

class MovieDetailBackdropWidget extends StatelessWidget {
  final String? backdropPath;

  const MovieDetailBackdropWidget({super.key, required this.backdropPath});

  @override
  Widget build(BuildContext context) {
    if (backdropPath == null) {
      return Container(
        color: Colors.black26,
        child: const Center(child: Icon(Icons.movie, size: 64)),
      );
    }
    return CachedNetworkImage(
      imageUrl: '${TmdbImageConfig.backdropW1280}$backdropPath',
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.broken_image, size: 48)),
    );
  }
}
