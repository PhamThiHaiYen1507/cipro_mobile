import 'package:base_project/layers/data/source/api_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getDio(
      @Named('api_cookie_intercepter') Interceptor apiCookieIntercepter) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        contentType: Headers.jsonContentType,
      ),
    )..interceptors.addAll([apiCookieIntercepter]);

    return dio;
  }

  @singleton
  ApiClient getApiClient(Dio dio) =>
      ApiClient(dio, baseUrl: 'http://10.0.2.2:3001');

  @singleton
  @Named('github_dio')
  Dio getDioGithub() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        contentType: Headers.jsonContentType,
      ),
    );

    return dio;
  }
}
