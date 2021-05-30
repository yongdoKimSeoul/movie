import 'package:flutter/material.dart';
import 'package:just_test/src/model/movie_actor_model.dart';
import 'package:just_test/src/model/movie_detail_model.dart';
import 'package:just_test/src/model/movie_genres_model.dart';
import 'package:just_test/src/model/movie_review_model.dart';
import 'package:just_test/src/services/movie_service.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:logger/logger.dart';

class MovieDetailViewModel extends ChangeNotifier {
  Logger _logger = Logger();

  bool get isLoading => _isLoading;
  bool _isLoading = false;
  MovieService _movieService = locator<MovieService>();

  MovieDetailModel get movieDetailInfo => _movieDetailInfo;
  MovieDetailModel _movieDetailInfo;

  List<MovieGenresModel> get movieGenresList => _movieGenresList;
  List<MovieGenresModel> _movieGenresList = [];

  List<MovieActorModel> get movieActorsList => _movieActorsList;
  List<MovieActorModel> _movieActorsList = [];

  List<MovieReviewModel> get movieReviewList => _movieReviewList;
  List<MovieReviewModel> _movieReviewList = [];

  int get movieId => _movieId;
  int _movieId;

  MovieDetailViewModel(int movieId) {
    _movieId = movieId;
  }

  Future initialize() async {
    setLoadingStatus(true);
    await getGenresInfo();
    await getMovieDetailInfo();
    await getActorsInfo();
    await getReviewInfo();
    setLoadingStatus(false);

    notifyListeners();
  }

  Future getMovieDetailInfo() async {
    var result = await _movieService.getMovieDetail(_movieId);
    if (result.result) {
      _movieDetailInfo = result.value;
    } else {
      _logger.e('getMovieDetailInfo not working');
    }
  }

  void setLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future getGenresInfo() async {
    var result = await _movieService.getGenresInfo(addKr: '&language=ko');
    if (result.result) {
      _movieGenresList = result.value;
    } else {
      _logger.e('getGenresInfo not working');
    }
  }

  //getActorsInfo

  Future getActorsInfo() async {
    var result = await _movieService.getActorsInfo(_movieId);
    if (result.result) {
      _movieActorsList = result.value;
    } else {
      _logger.e('getGenresInfo not working');
    }
  }

  Future getReviewInfo() async {
    var result = await _movieService.getReviewInfo(_movieId);
    if (result.result) {
      _movieReviewList = result.value;
    } else {
      _logger.e('getReviewInfo not working');
    }
  }

  String getGenres(List<Genres> list) {
    List<String> genreNames = [];

    list.forEach((selectedValue) {
      _movieGenresList.forEach((genresValue) {
        if (selectedValue.id == genresValue.id) {
          genreNames.add(genresValue.name);
        }
      });
    });

    var listToString = genreNames.join(", ");
    return listToString;
  }
}
