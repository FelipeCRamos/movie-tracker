import 'package:movie_tracker/features/detail/domain/entities/genre.dart';

class MovieDetail {
  final int id;
  final String title;
  final String originalTitle;
  final String? tagline;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final int? runtime;
  final double voteAverage;
  final int voteCount;
  final String status;
  final List<Genre> genres;
  final int budget;
  final int revenue;
  final String? homepage;
  final String originalLanguage;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.originalTitle,
    this.tagline,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.status,
    required this.genres,
    required this.budget,
    required this.revenue,
    this.homepage,
    required this.originalLanguage,
  });
}
