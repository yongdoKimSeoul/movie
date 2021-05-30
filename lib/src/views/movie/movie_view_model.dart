import 'package:flutter/material.dart';
import 'package:just_test/src/model/movie_genres_model.dart';
import 'package:just_test/src/model/movie_info_model.dart';
import 'package:just_test/src/services/movie_service.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:logger/logger.dart';

class MovieViewModel extends ChangeNotifier {
  Logger _logger = Logger();

  MovieService _movieService = locator<MovieService>();

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<MovieModel> get movieNowPlayingInfoList => _movieNowPlayingInfoList;
  List<MovieModel> _movieNowPlayingInfoList = [];

  List<MovieModel> get movieUpComingInfoList => _movieUpComingInfoList;
  List<MovieModel> _movieUpComingInfoList = [];

  List<MovieModel> get moviePopularInfoList => _moviePopularInfoList;
  List<MovieModel> _moviePopularInfoList = [];

  List<MovieModel> get movieTopRatedInfoList => _movieTopRatedInfoList;
  List<MovieModel> _movieTopRatedInfoList = [];

  List<MovieGenresModel> get movieGenresList => _movieGenresList;
  List<MovieGenresModel> _movieGenresList = [];

  Future initialize() async {
    setLoadingStatus(true);
    await getNowPlayingInfo();
    await getUpComingInfo();
    await getGenresInfo();
    await getPopularInfo();
    await getTopRatedInfo();
    setLoadingStatus(false);
    notifyListeners();
  }

  Future getNowPlayingInfo() async {
    var result = await _movieService.getMovieNowPlayingInfo();
    if (result.result) {
      _movieNowPlayingInfoList = result.value;
    } else {
      _logger.e('getNowPlayingInfo not working');
    }
  }

  Future getUpComingInfo() async {
    var result = await _movieService.getMovieUpComingInfo();
    if (result.result) {
      _movieUpComingInfoList = result.value;
      var tempList = _movieUpComingInfoList.sublist(0, 3);
      _movieUpComingInfoList.clear();
      _movieUpComingInfoList.addAll(tempList);
    } else {
      _logger.e('getUpComingInfo not working');
    }
  }

  Future getGenresInfo() async {
    var result = await _movieService.getGenresInfo();
    if (result.result) {
      _movieGenresList = result.value;
    } else {
      _logger.e('getGenresInfo not working');
    }
  }

  Future getPopularInfo() async {
    var result = await _movieService.getPopularInfo();
    if (result.result) {
      _moviePopularInfoList = result.value;
      var tempList = _moviePopularInfoList.sublist(0, 3);
      _moviePopularInfoList.clear();
      _moviePopularInfoList.addAll(tempList);
    } else {
      _logger.e('getPopularInfo not working');
    }
  }

  Future getTopRatedInfo() async {
    var result = await _movieService.getTopRatedInfo();
    if (result.result) {
      _movieTopRatedInfoList = result.value;
      var tempList = _movieTopRatedInfoList.sublist(0, 3);
      _movieTopRatedInfoList.clear();
      _movieTopRatedInfoList.addAll(tempList);
    } else {
      _logger.e('getPopularInfo not working');
    }
  }

  void setLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  double getMovieRate(int index, List list) {
    double halfValue = (list[index].voteAverage / 2).ceil().toDouble();
    return halfValue;
  }

  String getGenres(List<int> list) {
    List<String> genreNames = [];

    list.forEach((selectedValue) {
      _movieGenresList.forEach((genresValue) {
        if (selectedValue == genresValue.id) {
          genreNames.add(genresValue.name);
        }
      });
    });

    var listToString = genreNames.join(", ");
    return listToString;
  }
}
