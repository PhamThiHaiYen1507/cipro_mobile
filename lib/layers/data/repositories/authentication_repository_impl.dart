import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/logger/logger.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/request/github_token_request.dart';
import 'package:base_project/layers/data/request/login_request.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/data/source/github_api_client.dart';
import 'package:base_project/layers/data/source/github_client.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/utils/enum/storage_key.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../request/register_account_request.dart';

const String _clientId = 'Ov23liA2mz5sfNyIITZc';
const String _clientSecret = 'a18481fbdf397f24271ba7d5773069bea69eb1e7';

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final ApiClient _client;

  final GithubClient _githubClient;

  final GithubApiClient _githubApiClient;

  AuthenticationRepositoryImpl(
      this._client, this._githubClient, this._githubApiClient);

  @override
  Future<ApiResponseData<bool>> login(String username, String password) async {
    try {
      await _client.login(LoginRequest(username, password));

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> loginWithGithub() async {
    try {
      OAuth2Client ghClient = GitHubOAuth2Client(
        redirectUri: 'doan://phamthihaiyen.app',
        customUriScheme: 'doan',
      );

      final oauth2Helper = OAuth2Helper(
        ghClient,
        clientId: _clientId,
        clientSecret: _clientSecret,
        scopes: ['read:user', 'user:email'],
      );

      await oauth2Helper.fetchToken();

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> handleGithubCallback(
      {String? code, String? state}) async {
    try {
      final res = await _githubClient.getGithubToken(GithubTokenRequest(
        clientId: _clientId,
        clientSecret: _clientSecret,
        code: code,
        state: state,
        redirectUri: 'doan://phamthihaiyen.app',
      ));

      final githubResponse = Uri.tryParse('?$res')?.queryParameters;

      if (githubResponse != null) {
        LocalStorage.put(
          StorageKey.githubAccessToken,
          [githubResponse['token_type'], githubResponse['access_token']]
              .join(' '),
        );

        _getGithubUser();

        return const Right(true);
      }

      throw Exception();
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  Future<ApiResponseData<bool>> _getGithubUser() async {
    try {
      final res = await _githubApiClient.getGithubUser();

      logD(res);
      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> registerAccount(String username,
      String password, String confirmPassword, String email) async {
    try {
      await _client.registerAccount(
          RegisterAccountRequest(username, password, confirmPassword, email));

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> logout() async {
    try {
      await _client.logout();

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
