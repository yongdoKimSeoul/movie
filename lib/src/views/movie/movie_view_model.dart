import 'package:flutter/material.dart';
import 'package:just_test/src/model/movie_now_playing_info.dart';
import 'package:just_test/src/services/movie_service.dart';
import 'package:just_test/src/utils/locator.dart';

class MovieViewModel extends ChangeNotifier {

  MovieService _movieService = locator<MovieService>();

  bool get isLoading => _isLoading;
  bool _isLoading = false;
  MovieNowPlayingInfo _movieNowPlayingInfo;



  Future initialize() async{
    setLoadingStatus(true);
    await getNowPlayingInfo();
    setLoadingStatus(false);


    print(_movieNowPlayingInfo);
    notifyListeners();
  }

  Future getNowPlayingInfo()async{
    var result =  await _movieService.getMovieNowPlayingInfo();
    if(result.result){
      _movieNowPlayingInfo = result.value;
    }
  }

  void setLoadingStatus(bool value){
    _isLoading= value;
    notifyListeners();
  }

}