import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/features/home/domain/entities/movie_page.dart';

enum MovieCategory { popular, nowPlaying, topRated, upcoming }

abstract interface class MovieRepository {
  Future<Either<Failure, MoviePage>> getMovies({
    required MovieCategory category,
    required int page,
  });

  Future<Either<Failure, MoviePage>> searchMovies({
    required String query,
    required int page,
  });
}
