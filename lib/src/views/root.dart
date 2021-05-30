import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_test/src/utils/router.dart';
import 'package:just_test/src/views/movie/movie_view.dart';

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MovieView(),
        getPages: RouterList.routerList
    );
  }
}