import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_test/src/config/adress.dart';
import 'package:just_test/src/config/color_theme.dart';

import 'custom_indicator.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;

  const ImageLoader({Key key, this.imageUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      imageUrl: Address.BASIC_URL + imageUrl,
      placeholder: (context, url) => CustomIndicator(),
      errorWidget: (context, url, error) => Icon(
        Icons.error_outline_outlined,
        color: ColorTheme.blackZero,
      ),
    );
  }
}
