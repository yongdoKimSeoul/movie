import 'package:flutter/material.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/move_card_item.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';

import '../movie_view_model.dart';

class MovieCertainListWidget extends StatelessWidget {
  final MovieViewModel model;
  final String title;
  final List list;

  const MovieCertainListWidget({Key key, this.title, this.list, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: FontTheme.notoBold
              .copyWith(color: ColorTheme.blackZero, fontSize: 20),
        ),
        SizedBox(
          height: 16,
        ),
        Column(
          children: list
              .map((value) => movieCertainItem(
                  list: list, model: model, index: list.indexOf(value)))
              .toList(),
        )
      ],
    );
  }
}

Widget movieCertainItem({MovieViewModel model, int index, List list}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        MovieCardItem(
          value: list[index],
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
                  list[index].originalTitle,
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
                      list,
                    )),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        model.getGenres(list[index].genreIds),
                        style: FontTheme.notoRegular
                            .copyWith(color: ColorTheme.nineA, fontSize: 9),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      list[index].releaseDate,
                      style: FontTheme.notoRegular
                          .copyWith(color: ColorTheme.nineA, fontSize: 9),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
