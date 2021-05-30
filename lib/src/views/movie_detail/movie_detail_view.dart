import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:stacked/stacked.dart';

import 'movie_detail_view_model.dart';

class MovieDetailView extends StatelessWidget {
  final int movieId;

  const MovieDetailView({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieDetailViewModel>.reactive(
      viewModelBuilder: () => MovieDetailViewModel(movieId),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        body: model.isLoading
            ? CustomIndicator()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 23,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Colors.blue,
                            ),
                            onPressed: () => Get.back()),
                        Text(model.movieDetailInfo.releaseDate),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
