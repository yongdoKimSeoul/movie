import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_test/src/views/movie_detail/movie_detail_view.dart';

import 'imageLoader.dart';

enum SizeType { big, small }

class MovieCardItem extends StatelessWidget {
  final value;
  final SizeType sizeType;

  const MovieCardItem({Key key, this.sizeType, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bigWidth = MediaQuery.of(context).size.width * 0.375;
    var smallWidth = MediaQuery.of(context).size.width * 0.14;

    return GestureDetector(
      onTap: () => Get.to(() => MovieDetailView(
            movieId: value.id,
          )),
      child: Container(
        // color: Colors.pink,
        width: sizeType == SizeType.big ? bigWidth : smallWidth,
        height: sizeType == SizeType.big ? bigWidth * 1.53 : smallWidth * 1.53,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ImageLoader(imageUrl: value.posterPath ),
        ),
      ),
    );
  }
}
