import 'package:injectable/injectable.dart';
import 'package:just_test/src/http/http_service_manager.dart';
import 'package:just_test/src/model/movie_actor_model.dart';
import 'package:just_test/src/model/movie_detail_model.dart';
import 'package:just_test/src/model/movie_genres_model.dart';
import 'package:just_test/src/model/movie_info_model.dart';
import 'package:just_test/src/services/service_response.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:logger/logger.dart';

@lazySingleton
class MovieService {
  final HttpServiceManager _httpServiceManager = locator<HttpServiceManager>();
  Logger _logger = Logger();

  MovieService() {
    movieServiceInit();
  }

  Future movieServiceInit() async {
    await getMovieNowPlayingInfo();
    await getMovieUpComingInfo();
    await getGenresInfo();
    await getPopularInfo();
    await getTopRatedInfo();
  }

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

  Future<ServiceResponse<List<MovieModel>>> getPopularInfo() async {
    try {
      var res = await _httpServiceManager.movieAddressReq(address: 'popular');
      if ((res['results']) != null) {
        List<MovieModel> popularList = (res['results'] as List)
            .map((item) => MovieModel.fromJson(item))
            .toList();
        // _logger.d(res);
        return ServiceResponse(result: true, value: popularList);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(result: false, value: null, errorMsg: "Error");
    }
  }

  Future<ServiceResponse<List<MovieModel>>> getTopRatedInfo() async {
    try {
      var res = await _httpServiceManager.movieAddressReq(address: 'top_rated');
      if ((res['results']) != null) {
        List<MovieModel> topRatedList = (res['results'] as List)
            .map((item) => MovieModel.fromJson(item))
            .toList();
        // _logger.d(res);
        return ServiceResponse(result: true, value: topRatedList);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(result: false, value: null, errorMsg: "Error");
    }
  }

  Future<ServiceResponse<MovieDetailModel>> getMovieDetail(int movieId) async {
    try {
      var res = await _httpServiceManager.movieDetailReq(movieId: movieId);
      if (res != null) {
        MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(res);
        return ServiceResponse(result: true, value: movieDetailModel);
      } else {
        return ServiceResponse(result: false, errorMsg: "Null!");
      }
    } catch (e) {
      _logger.d(e);
      return ServiceResponse(result: false, errorMsg: "Error!");
    }
  }

  //movieGenresReq
  Future<ServiceResponse<List<MovieGenresModel>>> getGenresInfo(
      {String addKr}) async {
    try {
      var res = await _httpServiceManager.movieGenresReq(addKr: addKr);
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

  Future<ServiceResponse<List<MovieActorModel>>> getActorsInfo(
      int movieId) async {
    try {
      var res = await _httpServiceManager.movieActorsReq(movieId: movieId);
      if (res['cast'] != null) {
        List<MovieActorModel> actorList = (res['cast'] as List)
            .map((item) => MovieActorModel.fromJson(item))
            .toList();
        return ServiceResponse(result: true, value: actorList);
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
