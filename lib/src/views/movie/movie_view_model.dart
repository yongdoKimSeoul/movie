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

  List<MovieGenresModel> get movieGenresList => _movieGenresList;
  List<MovieGenresModel> _movieGenresList = [];

  Future initialize() async {
    setLoadingStatus(true);
    await getNowPlayingInfo();
    await getUpComingInfo();
    await getGenresInfo();
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
