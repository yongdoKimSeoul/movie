import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@lazySingleton
class HttpServiceManager {
  Dio _dio = Dio();
  Logger _logger = Logger();
  String apiKey = dotenv.env['API_KEY'];

  HttpServiceManager() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3';
  }


  //popular now_playing...
  Future<dynamic> movieAddressReq({@required String address}) async {
    try {
      var res = await get('/movie/$address?api_key=$apiKey&language=ko');
      return res;
    } catch (e) {
      _logger.v(e);
    }
  }

  Future<dynamic> movieGenresReq() async {
    try {
      var res = await get('/genre/movie/list?api_key=$apiKey');
      return res;
    } catch (e) {
      _logger.v(e);
    }
  }

  Future<dynamic> movieDetailReq({@required int movieId}) async {
    try {
      var res = await get('/movie/$movieId?api_key=$apiKey&language=ko');
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
