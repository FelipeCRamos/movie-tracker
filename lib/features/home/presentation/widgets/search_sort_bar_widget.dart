import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/home/domain/entities/search_sort.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_state.dart';

class SearchSortBarWidget extends StatelessWidget {
  const SearchSortBarWidget({super.key});

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

        if (searchQuery.isEmpty) return const SizedBox.shrink();

        final activeSort = switch (state) {
          HomeLoaded() => state.activeSort,
          HomeLoadingMore() => state.activeSort,
          _ => null,
        };

        return SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            children: [
              _SortChipItem(
                label: 'Rate',
                field: SearchSortField.rate,
                activeSort: activeSort,
                onTap: () =>
                    context.read<HomeCubit>().applySort(SearchSortField.rate),
              ),
              _SortChipItem(
                label: 'Date',
                field: SearchSortField.date,
                activeSort: activeSort,
                onTap: () =>
                    context.read<HomeCubit>().applySort(SearchSortField.date),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SortChipItem extends StatelessWidget {
  final String label;
  final SearchSortField field;
  final SearchSort? activeSort;
  final VoidCallback onTap;

  const _SortChipItem({
    required this.label,
    required this.field,
    required this.activeSort,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = activeSort?.field == field;
    final isAscending = activeSort?.ascending ?? true;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (isActive) ...[
              const SizedBox(width: 4),
              Icon(
                isAscending
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 14,
              ),
            ],
          ],
        ),
        selected: isActive,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
