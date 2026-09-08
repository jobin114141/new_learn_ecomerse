import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('==================== HTTP REQUEST ====================');
      debugPrint('--> ${options.method.toUpperCase()} ${options.uri}');
      debugPrint('Headers: ${options.headers}');
      if (options.data != null) {
        debugPrint('Body: ${options.data}');
      }
      debugPrint('======================================================');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('==================== HTTP RESPONSE ====================');
      debugPrint('<-- ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.uri}');
      debugPrint('Response: ${response.data}');
      debugPrint('=======================================================');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('==================== HTTP ERROR ====================');
      debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
      debugPrint('Message: ${err.message}');
      if (err.response?.data != null) {
        debugPrint('Error Body: ${err.response?.data}');
      }
      debugPrint('====================================================');
    }
    super.onError(err, handler);
  }
}
