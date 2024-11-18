import 'package:base_project/utils/enum/storage_key.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';

@Named('github_authentication')
@Singleton(as: Interceptor)
class GithubAuthenticationIntercepter extends InterceptorsWrapper {
  GithubAuthenticationIntercepter();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = LocalStorage.get<String?>(StorageKey.githubAccessToken);
    if (accessToken?.isNotEmpty == true) {
      options.headers.putIfAbsent('Authorization', () => accessToken);
    }

    super.onRequest(options, handler);
  }
}
