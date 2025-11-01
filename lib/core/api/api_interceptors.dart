import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {

  ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // You can log or handle token expiration here if needed.
    super.onError(err, handler);
  }
}
