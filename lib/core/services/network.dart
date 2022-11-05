import 'package:dio/dio.dart';
import 'package:simba_courier/core/services/cache.dart';

class Remote {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.simbalogistic.co.tz',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    _dio.options.headers = {
      'Authorization':
          'Bearer ${Cache.getData(key: 'token').toString().trim()}',
      'Content-Type': 'application/json',
    };

    return await _dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required var data,
    Map<String, dynamic>? query,
  }) async {
    _dio.options.headers = {
      'Authorization':
          'Bearer ${Cache.getData(key: 'token').toString().trim()}',
      'Content-Type': 'application/json',
    };

    return await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return await _dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
