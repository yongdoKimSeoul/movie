import 'package:flutter/material.dart';
import 'package:just_test/src/model/MovieDetailModel.dart';
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

  int get movieId => _movieId;
  int _movieId;

  MovieDetailViewModel(int movieId) {
    _movieId = movieId;
  }

  Future initialize() async {
    setLoadingStatus(true);
    await getMovieDetailInfo();
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
}
