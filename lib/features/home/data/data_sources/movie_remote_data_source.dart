import 'package:dio/dio.dart';
import 'package:movie_tracker/core/error/exceptions.dart';
import 'package:movie_tracker/core/network/network_service.dart';
import 'package:movie_tracker/features/home/data/models/movie_page_model.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';

abstract interface class MovieRemoteDataSource {
  Future<MoviePageModel> getMovies({
    required MovieCategory category,
    required int page,
  });

  Future<MoviePageModel> searchMovies({
    required String query,
    required int page,
  });
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final NetworkService _networkService;

  const MovieRemoteDataSourceImpl(this._networkService);

  static const _categoryPaths = {
    MovieCategory.popular: '/3/movie/popular',
    MovieCategory.nowPlaying: '/3/movie/now_playing',
    MovieCategory.topRated: '/3/movie/top_rated',
    MovieCategory.upcoming: '/3/movie/upcoming',
  };

  @override
  Future<MoviePageModel> getMovies({
    required MovieCategory category,
    required int page,
  }) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        _categoryPaths[category]!,
        queryParameters: {'page': page},
      );
      return MoviePageModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }

  @override
  Future<MoviePageModel> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/3/search/movie',
        queryParameters: {'query': query, 'page': page},
      );
      return MoviePageModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}
