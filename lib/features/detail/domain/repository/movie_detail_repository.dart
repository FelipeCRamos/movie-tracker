import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';

abstract interface class MovieDetailRepository {
  Future<Either<Failure, MovieDetail>> getMovieDetail(int movieId);
}
