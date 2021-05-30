import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class HttpServiceManager {

  Dio _dio = Dio();
  Logger _logger = Logger();

  HttpServiceManager() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3/movie';
  }

  Future<dynamic> movieNowPlayingReq() async {
    try {
      var res = await get('/now_playing?api_key=3f7508b245d1a1baf58afb66d3481319&&language=ko');
      return res;
    } catch (e) {
      _logger.v(e);
    }
  }

  // Base Http Methods
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      _logger.w(e);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      _logger.d(data);
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.d(response.data);
      return response.data;
    } catch (e) {
      _logger.d(e);
    }
  }
}