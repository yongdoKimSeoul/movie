import 'package:injectable/injectable.dart';
import 'package:just_test/src/http/http_service_manager.dart';
import 'package:just_test/src/model/movie_now_playing_info.dart';
import 'package:just_test/src/services/service_response.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:logger/logger.dart';

@lazySingleton
class MovieService {
  final HttpServiceManager _httpServiceManager = locator<HttpServiceManager>();
  Logger _logger = Logger();
  MovieNowPlayingInfo _movieNowPlayingInfo;



  Future<ServiceResponse<List<MovieNowPlayingInfo>>> getMovieNowPlayingInfo() async {
    try {
      var res = await _httpServiceManager.movieNowPlayingReq();
      if((res['results']) != null) {
        print("here");
        //print(res);

        // // List<MovieNowPlayingInfo> movieList = (res['results'] as List).map((item) => MovieNowPlayingInfo.fromJson(item)).toList();
        // List<MovieNowPlayingInfo> movieList=[];


        List<MovieNowPlayingInfo> movieList = (res['results'] as List).map((item) => MovieNowPlayingInfo.fromJson(item)).toList();






        return ServiceResponse(result: true, value: movieList);
      } else {
        print('is null');
        return ServiceResponse(
            result: false, value: null, errorMsg: "results is null");
      }
    } catch (e) {
      print(e);
      return ServiceResponse(
          result: false, value: null, errorMsg: "Error");
    }
  }
}