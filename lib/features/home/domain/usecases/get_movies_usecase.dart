import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/core/usecases/usecase.dart';
import 'package:movie_tracker/features/home/domain/entities/movie_page.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';

class GetMoviesUseCase implements UseCase<MoviePage, GetMoviesParams> {
  final MovieRepository _repository;

  const GetMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, MoviePage>> call(GetMoviesParams params) =>
      _repository.getMovies(category: params.category, page: params.page);
}

class GetMoviesParams {
  final MovieCategory category;
  final int page;

  const GetMoviesParams({required this.category, required this.page});
}
