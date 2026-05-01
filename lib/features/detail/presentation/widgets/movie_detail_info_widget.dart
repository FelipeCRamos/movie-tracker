import 'package:flutter/material.dart';
import 'package:movie_tracker/features/detail/domain/entities/movie_detail.dart';
import 'package:movie_tracker/features/detail/presentation/widgets/genre_chip_widget.dart';

class MovieDetailInfoWidget extends StatelessWidget {
  final MovieDetail movie;

  const MovieDetailInfoWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movie.genres.isNotEmpty) ...[
            _GenreList(movie: movie),
            const SizedBox(height: 16),
          ],
          if (movie.overview.isNotEmpty) ...[
            const _SectionTitle(label: 'Overview'),
            const SizedBox(height: 8),
            Text(movie.overview),
            const SizedBox(height: 16),
          ],
          const _SectionTitle(label: 'Details'),
          const SizedBox(height: 8),
          _DetailsGrid(movie: movie),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String label;

  const _SectionTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _GenreList extends StatelessWidget {
  final MovieDetail movie;

  const _GenreList({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: movie.genres
          .map((genre) => GenreChipWidget(genre: genre))
          .toList(),
    );
  }
}

class _DetailsGrid extends StatelessWidget {
  final MovieDetail movie;

  const _DetailsGrid({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DetailRow(label: 'Status', value: movie.status),
        _DetailRow(label: 'Language', value: movie.originalLanguage.toUpperCase()),
        if (movie.budget > 0)
          _DetailRow(label: 'Budget', value: _formatCurrency(movie.budget)),
        if (movie.revenue > 0)
          _DetailRow(label: 'Revenue', value: _formatCurrency(movie.revenue)),
      ],
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(0)}K';
    }
    return '\$$amount';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
