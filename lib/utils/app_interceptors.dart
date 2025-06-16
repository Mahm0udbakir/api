// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('*** Request ***');
    print('uri: [34m${options.uri}[0m');
    print('method: ${options.method}');
    print('headers: ${options.headers}');
    print('data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('*** Response ***');
    print('statusCode: ${response.statusCode}');
    print('data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('*** DioError ***');
    print('uri: ${err.requestOptions.uri}');
    print('message: ${err.message}');
    print('type: ${err.type}');
    super.onError(err, handler);
  }
} 