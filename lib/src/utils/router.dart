import 'package:get/get.dart';
import 'package:just_test/src/views/movie/movie_view.dart';
import 'package:just_test/src/views/movie_detail/movie_detail_view.dart';

class RouterList {
  static var routerList = [
    GetPage(
      name: '/movie_view',
      page: () => MovieView(),
    ),
    GetPage(
      name: '/movie_detail_view',
      page: () => MovieDetailView(),
    ),
  ];
}