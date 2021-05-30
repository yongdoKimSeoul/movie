import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/move_card_item.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';

import '../movie_view_model.dart';

class UpComingWidget extends StatelessWidget {
  final MovieViewModel model;

  const UpComingWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "개봉 예정",
          style: FontTheme.notoBold
              .copyWith(color: ColorTheme.blackZero, fontSize: 20),
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: model.movieUpComingInfoList
              .map((value) => upComingItem(
                  model: model,
                  index: model.movieUpComingInfoList.indexOf(value)))
              .toList(),
        )
      ],
    );
  }
}

Widget upComingItem({MovieViewModel model, int index}) {
  var upComingInfo = model.movieUpComingInfoList[index];

  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        MovieCardItem(
          modeList: model.movieUpComingInfoList,
          index: index,
          sizeType: SizeType.small,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  upComingInfo.originalTitle,
                  style: FontTheme.notoMedium
                      .copyWith(color: ColorTheme.blackZero, fontSize: 14),
                ),
                SizedBox(
                  height: 4,
                ),
                MovieRate(
                    starSize: 9,
                    value: model.getMovieRate(
                      index,
                      model.movieUpComingInfoList,
                    )),
                SizedBox(height: 16,),
                Text(
                  model.getGenres(upComingInfo.genreIds),
                  style: FontTheme.notoRegular
                      .copyWith(color: ColorTheme.nineA, fontSize: 9),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
