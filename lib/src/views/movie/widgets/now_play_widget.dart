import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';
import 'package:just_test/src/views/movie/movie_view_model.dart';

import '../../../globalWidget/move_card_item.dart';

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
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.movieNowPlayingInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      child: MovieCardItem(
                        modeList: model.movieNowPlayingInfoList,
                        index: index,
                        sizeType: SizeType.big,
                      ),
                      padding: EdgeInsets.only(right: 17),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          model.movieNowPlayingInfoList[index].originalTitle,
                          style: FontTheme.notoMedium.copyWith(
                              fontSize: 12, color: ColorTheme.blackZero),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    MovieRate(value: model.getMovieRate(index, model.movieNowPlayingInfoList)),
                  ],
                );
              }),
        )
      ],
    );
  }
}
