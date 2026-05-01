import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/home/domain/entities/movie.dart';
import 'package:movie_tracker/features/home/domain/entities/search_sort.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';
import 'package:movie_tracker/features/home/domain/usecases/get_movies_usecase.dart';
import 'package:movie_tracker/features/home/domain/usecases/search_movies_usecase.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase _getMovies;
  final SearchMoviesUseCase _searchMovies;

  HomeCubit({
    required GetMoviesUseCase getMovies,
    required SearchMoviesUseCase searchMovies,
  })  : _getMovies = getMovies,
        _searchMovies = searchMovies,
        super(const HomeInitial());

  Future<void> loadMovies({
    MovieCategory category = MovieCategory.popular,
    String query = '',
  }) async {
    emit(HomeLoading(
      activeFilter: category,
      searchQuery: query,
    ));
    await _fetchAndEmit(
      category: category,
      query: query,
      page: 1,
      existingMovies: const [],
      activeSort: null,
    );
  }

  Future<void> loadNextPage() async {
    final current = state;
    if (current is! HomeLoaded || !current.hasMore) return;

    emit(HomeLoadingMore(
      currentMovies: current.movies,
      activeFilter: current.activeFilter,
      searchQuery: current.searchQuery,
      activeSort: current.activeSort,
    ));

    await _fetchAndEmit(
      category: current.activeFilter,
      query: current.searchQuery,
      page: current.currentPage + 1,
      existingMovies: current.movies,
      activeSort: current.activeSort,
    );
  }

  Future<void> changeFilter(MovieCategory category) =>
      loadMovies(category: category);

  Future<void> search(String query) =>
      loadMovies(category: MovieCategory.popular, query: query);

  Future<void> clearSearch(MovieCategory category) =>
      loadMovies(category: category);

  void applySort(SearchSortField field) {
    final current = state;
    if (current is! HomeLoaded) return;

    final newSort = current.activeSort?.field == field
        ? current.activeSort!.toggleDirection()
        : SearchSort(field: field, ascending: false);

    emit(HomeLoaded(
      movies: _sortMovies(current.movies, newSort),
      activeFilter: current.activeFilter,
      searchQuery: current.searchQuery,
      currentPage: current.currentPage,
      totalPages: current.totalPages,
      hasMore: current.hasMore,
      activeSort: newSort,
    ));
  }

  Future<void> _fetchAndEmit({
    required MovieCategory category,
    required String query,
    required int page,
    required List<Movie> existingMovies,
    required SearchSort? activeSort,
  }) async {
    final result = query.isNotEmpty
        ? await _searchMovies(SearchMoviesParams(query: query, page: page))
        : await _getMovies(GetMoviesParams(category: category, page: page));

    result.fold(
      (failure) => emit(HomeError(
        message: failure.message,
        activeFilter: category,
        searchQuery: query,
      )),
      (moviePage) {
        final merged = [...existingMovies, ...moviePage.results];
        emit(HomeLoaded(
          movies: _sortMovies(merged, activeSort),
          activeFilter: category,
          searchQuery: query,
          currentPage: moviePage.page,
          totalPages: moviePage.totalPages,
          hasMore: moviePage.page < moviePage.totalPages,
          activeSort: activeSort,
        ));
      },
    );
  }

  List<Movie> _sortMovies(List<Movie> movies, SearchSort? sort) {
    if (sort == null) return movies;
    final sorted = List<Movie>.from(movies);
    sorted.sort((a, b) {
      switch (sort.field) {
        case SearchSortField.rate:
          final cmp = a.voteAverage.compareTo(b.voteAverage);
          return sort.ascending ? cmp : -cmp;
        case SearchSortField.date:
          final cmp = a.releaseDate.compareTo(b.releaseDate);
          return sort.ascending ? cmp : -cmp;
      }
    });
    return sorted;
  }
}
