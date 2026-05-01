abstract final class AppRoutes {
  static const home = '/';
  static const movieDetail = '/movie/:id';

  static String movieDetailPath(int id) => '/movie/$id';
}
