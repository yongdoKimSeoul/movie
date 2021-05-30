import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 23,
                          ),
                          nowPlaying(model: model),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}

Widget nowPlaying({@required MovieViewModel model}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "현재 상영중",
        style: FontTheme.notoBold
            .copyWith(color: ColorTheme.blackZero, fontSize: 20),
      ),
      SizedBox(
        height: 23,
      ),
      // Container(
      //   height: 300,
      //   child: ListView.builder(
      //       scrollDirection: Axis.horizontal,
      //       padding: const EdgeInsets.all(8),
      //       itemCount: model.,
      //       itemBuilder: (BuildContext context, int index) {
      //         return postImage();
      //       }),
      // )
    ],
  );
}

// Widget postImage(){
//   return CachedNetworkImage(
//     imageUrl: "http://via.placeholder.com/350x150",
//     placeholder: (context, url) => CircularProgressIndicator(),
//     errorWidget: (context, url, error) => Icon(Icons.error),
//   );
// }
