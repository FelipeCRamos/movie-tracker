import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_tracker/core/network/network_service.dart';
import 'package:movie_tracker/core/network/tmdb_v3_network_service.dart';
import 'package:movie_tracker/features/detail/data/data_sources/movie_detail_remote_data_source.dart';
import 'package:movie_tracker/features/detail/data/repository/movie_detail_repository_impl.dart';
import 'package:movie_tracker/features/detail/domain/repository/movie_detail_repository.dart';
import 'package:movie_tracker/features/detail/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movie_tracker/features/detail/presentation/bloc/movie_detail_cubit.dart';
import 'package:movie_tracker/features/home/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_tracker/features/home/data/repository/movie_repository_impl.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';
import 'package:movie_tracker/features/home/domain/usecases/get_movies_usecase.dart';
import 'package:movie_tracker/features/home/domain/usecases/search_movies_usecase.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/navigation_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  const apiKey = String.fromEnvironment('TMDB_API_KEY');

  // ── Infrastructure ────────────────────────────────────────────────────────
  sl.registerLazySingleton<NetworkService>(
    () => TmdbV3NetworkService(
      Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org',
          headers: {
            'Authorization': 'Bearer $apiKey',
            'accept': 'application/json',
          },
        ),
      )..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        ),
    ),
  );

  // ── Data ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl<NetworkService>()),
  );
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl<MovieRemoteDataSource>()),
  );

  sl.registerLazySingleton<MovieDetailRemoteDataSource>(
    () => MovieDetailRemoteDataSourceImpl(sl<NetworkService>()),
  );
  sl.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(sl<MovieDetailRemoteDataSource>()),
  );

  // ── Domain ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetMoviesUseCase(sl<MovieRepository>()));
  sl.registerLazySingleton(() => SearchMoviesUseCase(sl<MovieRepository>()));
  sl.registerLazySingleton(
    () => GetMovieDetailUseCase(sl<MovieDetailRepository>()),
  );

  // ── Presentation ──────────────────────────────────────────────────────────
  sl.registerFactory(() => NavigationCubit());
  sl.registerFactory(
    () => HomeCubit(
      getMovies: sl<GetMoviesUseCase>(),
      searchMovies: sl<SearchMoviesUseCase>(),
    ),
  );
  sl.registerFactory(
    () => MovieDetailCubit(getMovieDetail: sl<GetMovieDetailUseCase>()),
  );
}
