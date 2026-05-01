import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/detail/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movie_tracker/features/detail/presentation/bloc/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetailUseCase _getMovieDetail;

  MovieDetailCubit({required GetMovieDetailUseCase getMovieDetail})
      : _getMovieDetail = getMovieDetail,
        super(const MovieDetailInitial());

  Future<void> loadMovieDetail(int movieId) async {
    emit(const MovieDetailLoading());
    final result = await _getMovieDetail(movieId);
    result.fold(
      (failure) => emit(MovieDetailError(message: failure.message, movieId: movieId)),
      (movie) => emit(MovieDetailLoaded(movie: movie)),
    );
  }
}
