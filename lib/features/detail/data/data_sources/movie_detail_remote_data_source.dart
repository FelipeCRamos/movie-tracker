import 'package:dio/dio.dart';
import 'package:movie_tracker/core/error/exceptions.dart';
import 'package:movie_tracker/core/network/network_service.dart';
import 'package:movie_tracker/features/detail/data/models/movie_detail_model.dart';

abstract interface class MovieDetailRemoteDataSource {
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

class MovieDetailRemoteDataSourceImpl implements MovieDetailRemoteDataSource {
  final NetworkService _networkService;

  const MovieDetailRemoteDataSourceImpl(this._networkService);

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/3/movie/$movieId',
      );
      return MovieDetailModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}
