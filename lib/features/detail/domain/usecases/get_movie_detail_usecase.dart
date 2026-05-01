import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/core/usecases/usecase.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';
import 'package:movie_tracker/features/detail/domain/repository/movie_detail_repository.dart';

class GetMovieDetailUseCase implements UseCase<MovieDetail, int> {
  final MovieDetailRepository _repository;

  const GetMovieDetailUseCase(this._repository);

  @override
  Future<Either<Failure, MovieDetail>> call(int movieId) =>
      _repository.getMovieDetail(movieId);
}
