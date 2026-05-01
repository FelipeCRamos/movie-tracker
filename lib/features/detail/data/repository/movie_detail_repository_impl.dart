import 'package:fpdart/fpdart.dart';
import 'package:movie_tracker/core/error/exceptions.dart';
import 'package:movie_tracker/core/error/failure.dart';
import 'package:movie_tracker/features/detail/data/data_sources/movie_detail_remote_data_source.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';
import 'package:movie_tracker/features/detail/domain/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MovieDetailRemoteDataSource _remoteDataSource;

  const MovieDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int movieId) async {
    try {
      final result = await _remoteDataSource.getMovieDetail(movieId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Unexpected error'));
    }
  }
}
