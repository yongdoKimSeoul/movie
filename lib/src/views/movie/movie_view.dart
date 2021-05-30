import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:stacked/stacked.dart';

import 'movie_view_model.dart';

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
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: Column(
                        children: [
                          nowPlaying(model: model),

                        ],
                      ),
                    ),
                  ),
              )),
    );
  }
}

Widget nowPlaying({@required MovieViewModel model}){
  return Column(
    children: [
        Text("현재 상영중", style: FontTheme.notoBold.copyWith(color: ColorTheme.blackZero,fontSize: 20),)
    ],
  );
}