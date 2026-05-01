import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/core/usecases/usecase.dart';
import 'package:movie_tracker/features/home/domain/entities/movie_page.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';

class SearchMoviesUseCase implements UseCase<MoviePage, SearchMoviesParams> {
  final MovieRepository _repository;

  const SearchMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, MoviePage>> call(SearchMoviesParams params) =>
      _repository.searchMovies(query: params.query, page: params.page);
}

class SearchMoviesParams {
  final String query;
  final int page;

  const SearchMoviesParams({required this.query, required this.page});
}
