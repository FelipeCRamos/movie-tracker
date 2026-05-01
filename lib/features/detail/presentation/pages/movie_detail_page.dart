import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';
import 'package:movie_tracker/features/detail/presentation/bloc/movie_detail_cubit.dart';
import 'package:movie_tracker/features/detail/presentation/bloc/movie_detail_state.dart';
import 'package:movie_tracker/features/detail/presentation/widgets/movie_detail_backdrop_widget.dart';
import 'package:movie_tracker/features/detail/presentation/widgets/movie_detail_header_widget.dart';
import 'package:movie_tracker/features/detail/presentation/widgets/movie_detail_info_widget.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (_) =>
          GetIt.instance<MovieDetailCubit>()..loadMovieDetail(movieId),
      child: const _MovieDetailView(),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  const _MovieDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        return switch (state) {
          MovieDetailInitial() || MovieDetailLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          MovieDetailLoaded() => _MovieDetailContent(movie: state.movie),
          MovieDetailError() => _MovieDetailErrorView(state: state),
        };
      },
    );
  }
}

class _MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;

  const _MovieDetailContent({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: MovieDetailBackdropWidget(
                backdropPath: movie.backdropPath,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieDetailHeaderWidget(movie: movie),
                const Divider(height: 1),
                const SizedBox(height: 16),
                MovieDetailInfoWidget(movie: movie),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetailErrorView extends StatelessWidget {
  final MovieDetailError state;

  const _MovieDetailErrorView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(state.message),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context
                  .read<MovieDetailCubit>()
                  .loadMovieDetail(state.movieId),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
