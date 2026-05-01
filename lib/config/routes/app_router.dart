import 'package:go_router/go_router.dart';
import 'package:movie_tracker/config/routes/app_routes.dart';
import 'package:movie_tracker/features/detail/presentation/pages/movie_detail_page.dart';
import 'package:movie_tracker/features/home/presentation/pages/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.movieDetail,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MovieDetailPage(movieId: id);
      },
    ),
  ],
);
