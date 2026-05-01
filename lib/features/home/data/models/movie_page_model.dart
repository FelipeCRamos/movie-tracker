import 'package:movie_tracker/features/home/data/models/movie_model.dart';
import 'package:movie_tracker/features/home/domain/entities/movie_page.dart';

class MoviePageModel extends MoviePage {
  const MoviePageModel({
    required super.page,
    required super.totalPages,
    required super.totalResults,
    required super.results,
  });

  factory MoviePageModel.fromJson(Map<String, dynamic> json) => MoviePageModel(
        page: json['page'] as int,
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        results: (json['results'] as List<dynamic>)
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
