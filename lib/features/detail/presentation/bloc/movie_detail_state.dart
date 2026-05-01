import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';

sealed class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  const MovieDetailInitial();
}

class MovieDetailLoading extends MovieDetailState {
  const MovieDetailLoading();
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;

  const MovieDetailLoaded({required this.movie});
}

class MovieDetailError extends MovieDetailState {
  final String message;
  final int movieId;

  const MovieDetailError({required this.message, required this.movieId});
}
