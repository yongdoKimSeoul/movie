import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_test/src/config/adress.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';
import 'package:just_test/src/views/movie/widgets/movie_certain_list_widget.dart';
import 'package:stacked/stacked.dart';

import 'movie_view_model.dart';
import 'widgets/now_play_widget.dart';

class MovieView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieViewModel>.reactive(
      viewModelBuilder: () => MovieViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
          body: model.isLoading
              ? CustomIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 23,
                          ),
                          NowPlayingWidget(model: model,),
                          SizedBox(
                            height: 30,
                          ),
                          MovieCertainListWidget(model:model, list: model.movieUpComingInfoList, title: "개봉 예정",),
                          MovieCertainListWidget(model:model, list: model.moviePopularInfoList, title: "인기",),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}

