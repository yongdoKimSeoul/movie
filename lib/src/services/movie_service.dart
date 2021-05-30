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



  Future<ServiceResponse<MovieNowPlayingInfo>> getMovieNowPlayingInfo() async {
    try {
      var res = await _httpServiceManager.movieNowPlayingReq();
      if (res != null) {
        _logger.d(res);
        var result = MovieNowPlayingInfo.fromJson(res['results']);
        _movieNowPlayingInfo = result;
        return ServiceResponse(result: true, value: _movieNowPlayingInfo);
      } else {
        return ServiceResponse(
            result: false, value: null, errorMsg: res['ErrorMsg']);
      }
    } catch (e) {
      return ServiceResponse(
          result: false, value: null, errorMsg: "Error");
    }
  }
}