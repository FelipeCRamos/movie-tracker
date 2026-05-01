import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/exceptions.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/features/home/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_tracker/features/home/domain/entities/movie_page.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;

  const MovieRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, MoviePage>> getMovies({
    required MovieCategory category,
    required int page,
  }) async {
    try {
      final result = await _remoteDataSource.getMovies(
        category: category,
        page: page,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, MoviePage>> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final result = await _remoteDataSource.searchMovies(
        query: query,
        page: page,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Unexpected error'));
    }
  }
}
