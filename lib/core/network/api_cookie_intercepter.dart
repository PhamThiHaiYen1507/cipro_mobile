import 'package:base_project/utils/enum/storage_key.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';

@Named('api_cookie_intercepter')
@Singleton(as: Interceptor)
class ApiCookieIntercepter extends InterceptorsWrapper {
  @override
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiCookie = LocalStorage.get<String>(StorageKey.apiCookie);

    options.headers['connection'] = 'keep-alive';

    if (apiCookie != null) {
      options.headers['cookie'] = apiCookie;
    }

    super.onRequest(options, handler);
  }

  @override
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final setCookieHeader = response.headers['set-cookie']?.firstOrNull;
    if (setCookieHeader != null) {
      final cookies = setCookieHeader.split(';');
      final cookie = cookies.first;
      LocalStorage.put(StorageKey.apiCookie, cookie);
    }

    super.onResponse(response, handler);
  }
}
