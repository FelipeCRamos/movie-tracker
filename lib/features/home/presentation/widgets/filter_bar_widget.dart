import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_state.dart';

class FilterBarWidget extends StatelessWidget {
  const FilterBarWidget({super.key});

  static const _labels = {
    MovieCategory.popular: 'Popular',
    MovieCategory.nowPlaying: 'Now Playing',
    MovieCategory.topRated: 'Top Rated',
    MovieCategory.upcoming: 'Upcoming',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final searchQuery = switch (state) {
          HomeLoaded() => state.searchQuery,
          HomeLoadingMore() => state.searchQuery,
          HomeError() => state.searchQuery,
          _ => '',
        };

        if (searchQuery.isNotEmpty) return const SizedBox.shrink();

        final activeFilter = switch (state) {
          HomeLoaded() => state.activeFilter,
          HomeLoadingMore() => state.activeFilter,
          HomeError() => state.activeFilter,
          HomeLoading() => state.activeFilter,
          _ => MovieCategory.popular,
        };

        return SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            children: MovieCategory.values
                .map(
                  (cat) => _FilterChipItem(
                    label: _labels[cat]!,
                    isSelected: activeFilter == cat,
                    onTap: () => context.read<HomeCubit>().changeFilter(cat),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
