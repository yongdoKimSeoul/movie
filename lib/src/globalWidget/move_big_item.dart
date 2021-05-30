import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_test/src/config/adress.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';
import 'package:just_test/src/views/movie/movie_view_model.dart';

enum SizeType{
  big,
  small
}

class MovieItem extends StatelessWidget {
  final MovieViewModel model;
  final int index;
  final SizeType sizeType;


  const MovieItem({Key key, this.model, this.index, this.sizeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = model.movieNowPlayingInfoList[index];

    return Container(
      color: Colors.pink,
      width: sizeType == SizeType.big ? MediaQuery.of(context).size.width * 0.36 :  MediaQuery.of(context).size.width * 0.14 ,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 17),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: Address.BASIC_URL + info.backdropPath,
                placeholder: (context, url) => CustomIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline_outlined,
                  color: ColorTheme.blackZero,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                info.originalTitle,
                style: FontTheme.notoMedium
                    .copyWith(fontSize: 12, color: ColorTheme.blackZero),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            height: 4,
          ),
          MovieRate(value: model.getMovieRate(index)),
        ],
      ),
    );
  }
}



