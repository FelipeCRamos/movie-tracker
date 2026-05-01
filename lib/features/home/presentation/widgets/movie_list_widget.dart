import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/home/domain/entities/movie.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:movie_tracker/features/home/presentation/widgets/movie_card_widget.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxExtent = _scrollController.position.maxScrollExtent;
    if (_scrollController.offset >= maxExtent - 200) {
      context.read<HomeCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeInitial() || HomeLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          HomeLoaded() => _MovieList(
              movies: state.movies,
              scrollController: _scrollController,
              isLoadingMore: false,
            ),
          HomeLoadingMore() => _MovieList(
              movies: state.currentMovies,
              scrollController: _scrollController,
              isLoadingMore: true,
            ),
          HomeError() => _ErrorView(state: state),
        };
      },
    );
  }
}

class _MovieList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;
  final bool isLoadingMore;

  const _MovieList({
    required this.movies,
    required this.scrollController,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: movies.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == movies.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: MovieCardWidget(movie: movies[index]),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final HomeError state;

  const _ErrorView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 12),
          Text(state.message),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.read<HomeCubit>().loadMovies(
                  category: state.activeFilter,
                  query: state.searchQuery,
                ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
