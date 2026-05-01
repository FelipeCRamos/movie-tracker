import 'package:movie_tracker/features/home/domain/entities/movie.dart';
import 'package:movie_tracker/features/home/domain/entities/search_sort.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  final MovieCategory activeFilter;
  final String searchQuery;

  const HomeLoading({
    required this.activeFilter,
    required this.searchQuery,
  });
}

class HomeLoadingMore extends HomeState {
  final List<Movie> currentMovies;
  final MovieCategory activeFilter;
  final String searchQuery;
  final SearchSort? activeSort;

  const HomeLoadingMore({
    required this.currentMovies,
    required this.activeFilter,
    required this.searchQuery,
    this.activeSort,
  });
}

class HomeLoaded extends HomeState {
  final List<Movie> movies;
  final MovieCategory activeFilter;
  final String searchQuery;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final SearchSort? activeSort;

  const HomeLoaded({
    required this.movies,
    required this.activeFilter,
    required this.searchQuery,
    required this.currentPage,
    required this.totalPages,
    required this.hasMore,
    this.activeSort,
  });
}

class HomeError extends HomeState {
  final String message;
  final MovieCategory activeFilter;
  final String searchQuery;

  const HomeError({
    required this.message,
    required this.activeFilter,
    required this.searchQuery,
  });
}
