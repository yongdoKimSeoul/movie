import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/move_big_item.dart';

import '../movie_view_model.dart';

class UpComingWidget extends StatelessWidget {
  final MovieViewModel model;

  const UpComingWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("개봉 예정", style: FontTheme.notoBold.copyWith(color: ColorTheme.blackZero, fontSize: 20),),
        SizedBox(height: 16,),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.movieNowPlayingInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieItem(model: model, index: index,sizeType: SizeType.small,);
              }),
        )
      ],
    );
  }
}
