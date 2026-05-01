import 'package:movie_tracker/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.popularity,
    required super.genreIds,
    required super.originalLanguage,
    required super.originalTitle,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
        releaseDate: (json['release_date'] as String?) ?? '',
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count'] as int,
        popularity: (json['popularity'] as num).toDouble(),
        genreIds: (json['genre_ids'] as List<dynamic>).cast<int>(),
        originalLanguage: json['original_language'] as String,
        originalTitle: json['original_title'] as String,
      );
}
