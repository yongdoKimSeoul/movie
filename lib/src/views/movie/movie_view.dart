
import 'package:flutter/material.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
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
                            height: MediaQuery.of(context).size.height *0.03,
                          ),
                          NowPlayingWidget(
                            model: model,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height *0.03,
                          ),
                          MovieCertainListWidget(
                            model: model,
                            list: model.movieUpComingInfoList,
                            title: "개봉 예정",
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          MovieCertainListWidget(
                            model: model,
                            list: model.moviePopularInfoList,
                            title: "인기",
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          MovieCertainListWidget(
                            model: model,
                            list: model.movieTopRatedInfoList,
                            title: "높은 평점",
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
