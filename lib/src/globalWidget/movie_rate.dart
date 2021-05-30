import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_test/src/config/color_theme.dart';

class MovieRate extends StatelessWidget {
  final double value;

  const MovieRate({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 15,
      ignoreGestures: true,
      initialRating: value,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: 5),
      itemBuilder: (context, _) => RotationTransition(
        turns: AlwaysStoppedAnimation(180 / 360),
        child: Icon(
          Icons.star,
          color: ColorTheme.primaryYellow,
        ),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
