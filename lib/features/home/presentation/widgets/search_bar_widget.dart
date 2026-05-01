import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/features/home/domain/repository/movie_repository.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_state.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  MovieCategory _activeFilter() {
    final state = context.read<HomeCubit>().state;
    return switch (state) {
      HomeLoaded() => state.activeFilter,
      HomeLoadingMore() => state.activeFilter,
      HomeError() => state.activeFilter,
      _ => MovieCategory.popular,
    };
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      context.read<HomeCubit>().clearSearch(_activeFilter());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      context.read<HomeCubit>().search(trimmed);
    });
  }

  void _onSubmitted(String value) {
    _debounce?.cancel();
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      context.read<HomeCubit>().clearSearch(_activeFilter());
    } else {
      context.read<HomeCubit>().search(trimmed);
    }
  }

  void _onClear() {
    _debounce?.cancel();
    _controller.clear();
    context.read<HomeCubit>().clearSearch(_activeFilter());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search movies...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _onClear,
          ),
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
