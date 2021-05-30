import 'package:injectable/injectable.dart';
import 'package:just_test/src/http/http_service_manager.dart';
import 'package:just_test/src/model/movie_genres_model.dart';
import 'package:just_test/src/model/movie_info_model.dart';
import 'package:just_test/src/services/service_response.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:logger/logger.dart';

@lazySingleton
class MovieService {
  final HttpServiceManager _httpServiceManager = locator<HttpServiceManager>();
  Logger _logger = Logger();
  MovieModel _movieNowPlayingInfo;

  //현재상영
  Future<ServiceResponse<List<MovieModel>>> getMovieNowPlayingInfo() async {
    try {
      var res =
          await _httpServiceManager.movieAddressReq(address: 'now_playing');
      if ((res['results']) != null) {
        List<MovieModel> nowPlayList = (res['results'] as List)
            .map((item) => MovieModel.fromJson(item))
            .toList();

        return ServiceResponse(result: true, value: nowPlayList);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(result: false, value: null, errorMsg: "Error");
    }
  }

  Future<ServiceResponse<List<MovieModel>>> getMovieUpComingInfo() async {
    try {
      var res = await _httpServiceManager.movieAddressReq(address: 'upcoming');
      if ((res['results']) != null) {
        List<MovieModel> upComingList = (res['results'] as List)
            .map((item) => MovieModel.fromJson(item))
            .toList();
        // _logger.d(res);
        return ServiceResponse(result: true, value: upComingList);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(result: false, value: null, errorMsg: "Error");
    }
  }

  //movieGenresReq
  Future<ServiceResponse<List<MovieGenresModel>>> getGenresInfo() async {
    try {
      var res = await _httpServiceManager.movieGenresReq();
      if (res['genres'] != null) {

        List<MovieGenresModel> genresList = (res['genres'] as List)
            .map((item) => MovieGenresModel.fromJson(item))
            .toList();
        return ServiceResponse(result: true, value: genresList);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(result: false, value: null, errorMsg: "Error");
    }
  }
}
