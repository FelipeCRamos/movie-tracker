import 'package:movie_tracker/features/home/domain/entities/movie.dart';

class MoviePage {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Movie> results;

  const MoviePage({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });
}
