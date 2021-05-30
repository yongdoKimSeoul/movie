import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_test/src/config/adress.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';
import 'package:just_test/src/views/movie/movie_view_model.dart';
import 'package:just_test/src/views/movie_detail/movie_detail_view.dart';

enum SizeType { big, small }

class MovieCardItem extends StatelessWidget {
  final value;
  final SizeType sizeType;

  const MovieCardItem({Key key, this.sizeType, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bigWidth = MediaQuery.of(context).size.width * 0.375;
    var smallWidth = MediaQuery.of(context).size.width * 0.14;

    return GestureDetector(
      onTap: ()=>Get.to(()=>MovieDetailView(movieId: value.id,)),
      child: Container(
        // color: Colors.pink,
        width: sizeType == SizeType.big ? bigWidth : smallWidth,
        height: sizeType == SizeType.big
            ? bigWidth* 1.53
            : smallWidth * 1.53,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: Address.BASIC_URL + value.posterPath,
            placeholder: (context, url) => CustomIndicator(),
            errorWidget: (context, url, error) => Icon(
              Icons.error_outline_outlined,
              color: ColorTheme.blackZero,
            ),
          ),
        ),
      ),
    );
  }
}
