import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/views/movie/movie_view_model.dart';

import '../../../globalWidget/move_big_item.dart';

class NowPlayingWidget extends StatelessWidget {
  final MovieViewModel model;

  const NowPlayingWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.movieNowPlayingInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieItem(model: model, index: index,sizeType: SizeType.big,);
              }),
        )
      ],
    );
  }
}
