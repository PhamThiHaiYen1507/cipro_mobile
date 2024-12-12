import 'package:base_project/core/logger/logger.dart';
import 'package:dio/dio.dart';

import 'api_exception.dart';

class ExceptionHandler {
  static ApiException handler(Exception e, [StackTrace? stackTrace]) {
    if (e is DioException) {
      logE({
        'exception': e.toString(),
        'statusCode': e.response?.statusCode,
        'statusMessage': e.response?.statusMessage,
        'url': e.response?.realUri.toString(),
        'response': e.response?.data,
      }, e.stackTrace);
      return _dioExceptionHandler(e);
    } else {
      logE(e, stackTrace);
      return ApiException(
        message: e.toString(),
      );
    }
  }

  static ApiException _dioExceptionHandler(DioException e) {
    switch (e.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.unknown:
        return ApiException(message: 'Lỗi hệ thống');
      case DioExceptionType.badResponse:
        if (e.response?.data is! Map) {
          return ApiException();
        }

        return ApiException(
            message: (e.response?.data?['errors'] is String)
                ? e.response!.data!['errors']
                : e.response?.data?['message']);
      default:
        return ApiException();
    }
  }
}
