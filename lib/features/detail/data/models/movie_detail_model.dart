import 'package:movie_tracker/features/detail/data/models/genre_model.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    super.tagline,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.releaseDate,
    super.runtime,
    required super.voteAverage,
    required super.voteCount,
    required super.status,
    required super.genres,
    required super.budget,
    required super.revenue,
    super.homepage,
    required super.originalLanguage,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        id: json['id'] as int,
        title: json['title'] as String,
        originalTitle: json['original_title'] as String,
        tagline: (json['tagline'] as String?)?.isEmpty == true
            ? null
            : json['tagline'] as String?,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
        releaseDate: (json['release_date'] as String?) ?? '',
        runtime: json['runtime'] as int?,
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count'] as int,
        status: json['status'] as String,
        genres: (json['genres'] as List<dynamic>)
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        budget: json['budget'] as int,
        revenue: json['revenue'] as int,
        homepage: (json['homepage'] as String?)?.isEmpty == true
            ? null
            : json['homepage'] as String?,
        originalLanguage: json['original_language'] as String,
      );
}
