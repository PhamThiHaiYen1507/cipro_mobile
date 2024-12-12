import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'github_api_client.g.dart';

@RestApi()
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String? baseUrl}) = _GithubApiClient;

  @GET('/user')
  Future<dynamic> getGithubUser();
}
