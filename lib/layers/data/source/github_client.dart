import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../request/github_token_request.dart';

part 'github_client.g.dart';

@RestApi()
abstract class GithubClient {
  factory GithubClient(Dio dio, {String? baseUrl}) = _GithubClient;

  @POST('/login/oauth/access_token')
  Future<dynamic> getGithubToken(
    @Body() GithubTokenRequest request,
  );
}
