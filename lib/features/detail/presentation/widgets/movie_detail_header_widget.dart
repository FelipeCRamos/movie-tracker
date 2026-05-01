import 'package:flutter/material.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';
import 'package:movie_tracker/shared/widgets/movie_poster_widget.dart';

class MovieDetailHeaderWidget extends StatelessWidget {
  final MovieDetail movie;

  const MovieDetailHeaderWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: MoviePosterWidget(
              posterPath: movie.posterPath,
              width: 110,
              height: 165,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: _MovieTitleInfo(movie: movie)),
        ],
      ),
    );
  }
}

class _MovieTitleInfo extends StatelessWidget {
  final MovieDetail movie;

  const _MovieTitleInfo({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (movie.originalTitle != movie.title) ...[
          const SizedBox(height: 2),
          Text(movie.originalTitle, style: textTheme.bodySmall),
        ],
        const SizedBox(height: 8),
        _RatingRow(voteAverage: movie.voteAverage, voteCount: movie.voteCount),
        const SizedBox(height: 8),
        _MetaRow(
          icon: Icons.calendar_today_rounded,
          label: movie.releaseDate,
        ),
        if (movie.runtime != null) ...[
          const SizedBox(height: 4),
          _MetaRow(
            icon: Icons.schedule_rounded,
            label: '${movie.runtime} min',
          ),
        ],
        if (movie.tagline != null) ...[
          const SizedBox(height: 8),
          Text(
            '"${movie.tagline}"',
            style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double voteAverage;
  final int voteCount;

  const _RatingRow({required this.voteAverage, required this.voteCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          voteAverage.toStringAsFixed(1),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(
          '($voteCount)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
