import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_test/src/config/color_theme.dart';
import 'package:just_test/src/config/font_theme.dart';
import 'package:just_test/src/globalWidget/custom_indicator.dart';
import 'package:just_test/src/globalWidget/imageLoader.dart';
import 'package:just_test/src/globalWidget/movie_rate.dart';
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
            : Stack(
                children: [
                  ImageLoader(
                    imageUrl: model.movieDetailInfo.backdropPath,
                  ),
                  blackFilter(),
                  SingleChildScrollView(
                      child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Colors.white,
                                ),
                                onPressed: () => Get.back()),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          movieDetail(model, context),
                        ],
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.165,
                        left: 16,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.375,
                          height:
                              MediaQuery.of(context).size.width * 0.375 * 1.53,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: ImageLoader(
                                imageUrl: model.movieDetailInfo.backdropPath,
                              )),
                        ),
                      )
                    ],
                  )),
                ],
              ),
      ),
    );
  }
}

Widget blackFilter() {
  return Container(color: ColorTheme.blackZero.withOpacity(0.4));
}

Widget movieDetail(MovieDetailViewModel model, BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
            )),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.375,
                    height: 10,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          model.movieDetailInfo.title,
                          style: FontTheme.notoBold.copyWith(
                              color: ColorTheme.blackZero, fontSize: 12),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Visibility(
                            visible: model.movieDetailInfo.adult,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    width: 1,
                                    color: ColorTheme.primaryRed,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, right: 4, bottom: 1, top: 1),
                                  child: Text(
                                    "Adult",
                                    style: FontTheme.notoBold.copyWith(
                                        color: ColorTheme.primaryRed,
                                        fontSize: 7),
                                  ),
                                ),
                              ),
                            )),
                        Text(
                          model.getGenres(model.movieDetailInfo.genres),
                          style: FontTheme.notoRegular
                              .copyWith(color: ColorTheme.bNine, fontSize: 11),
                        ),
                        Text(model.movieDetailInfo.releaseDate + " 발매",
                            style: FontTheme.notoRegular
                                .copyWith(color: ColorTheme.bNine, fontSize: 11)),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            MovieRate(
                              value: model.movieDetailInfo.voteAverage,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(model.movieDetailInfo.voteAverage.toString(),
                                style: FontTheme.notoRegular.copyWith(
                                    color: ColorTheme.primaryYellow,
                                    fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "개요",
                style: FontTheme.notoBold
                    .copyWith(color: ColorTheme.blackZero, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                model.movieDetailInfo.overview,
                style: FontTheme.notoRegular
                    .copyWith(color: ColorTheme.eightTwo, fontSize: 14),
              ),
              SizedBox(height: 24),
              actorsWidget(model, context),
              SizedBox(
                height: 24,
              ),
              movieReviewWidget(model, context),
            ],
          ),
        )),
  );
}

Widget actorsWidget(MovieDetailViewModel model, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "주요 출연진",
        style: FontTheme.notoBold
            .copyWith(color: ColorTheme.blackZero, fontSize: 16),
      ),
      SizedBox(
        height: 16,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.movieActorsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              width: 40,
                              height: 40,
                              child: model.movieActorsList[index].profilePath ==
                                      null
                                  ? Icon(Icons.person)
                                  : ImageLoader(
                                      imageUrl: model.movieActorsList[index]
                                          .profilePath))),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Text(
                          model.movieActorsList[index].name,
                          style: FontTheme.notoRegular.copyWith(
                              color: ColorTheme.blackZero, fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    ],
  );
}

Widget movieReviewWidget(MovieDetailViewModel model, BuildContext context) {
  print("model.movieReviewList.length," +
      model.movieReviewList.length.toString());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "리뷰",
        style: FontTheme.notoBold
            .copyWith(color: ColorTheme.blackZero, fontSize: 16),
      ),
      SizedBox(
        height: 16,
      ),
      if (model.movieReviewList.length == 0)
        Container(
          width: MediaQuery.of(context).size.width,
          height: 71,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                  child: Center(
                child: Text(
                  "아직 리뷰가 없습니다.",
                  style: FontTheme.notoRegular
                      .copyWith(color: ColorTheme.sixOne, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ))),
        )
      else
        ListView.builder(
            shrinkWrap: true,
            itemCount: model.movieReviewList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 71,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                        child: Container(
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.movieReviewList[index].content,
                          style: FontTheme.notoRegular
                              .copyWith(color: ColorTheme.sixOne, fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            model.movieReviewList[index].author,
                            style: FontTheme.notoRegular.copyWith(
                                color: ColorTheme.sixOne, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )))),
              );
            }),
      SizedBox(
        height: 76,
      ),
    ],
  );
}
