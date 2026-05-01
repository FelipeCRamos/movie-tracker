import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_tracker/features/favorites/presentation/pages/favorites_page.dart';
import 'package:movie_tracker/features/home/presentation/bloc/home_cubit.dart';
import 'package:movie_tracker/features/home/presentation/bloc/navigation_cubit.dart';
import 'package:movie_tracker/features/home/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:movie_tracker/features/home/presentation/widgets/filter_bar_widget.dart';
import 'package:movie_tracker/features/home/presentation/widgets/movie_list_widget.dart';
import 'package:movie_tracker/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:movie_tracker/features/home/presentation/widgets/search_sort_bar_widget.dart';
import 'package:movie_tracker/features/lists/presentation/pages/lists_page.dart';
import 'package:movie_tracker/features/settings/presentation/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) => GetIt.instance<NavigationCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => GetIt.instance<HomeCubit>()..loadMovies(),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NavigationCubit, int>(
          builder: (context, selectedIndex) {
            switch (selectedIndex) {
              case 0:
                return const Column(
                  children: [
                    SearchBarWidget(),
                    FilterBarWidget(),
                    SearchSortBarWidget(),
                    Expanded(child: MovieListWidget()),
                  ],
                );
              case 1:
                return const FavoritesPage();
              case 2:
                return const ListsPage();
              case 3:
                return const SettingsPage();
              default:
                return const Column(
                  children: [
                    SearchBarWidget(),
                    FilterBarWidget(),
                    SearchSortBarWidget(),
                    Expanded(child: MovieListWidget()),
                  ],
                );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
