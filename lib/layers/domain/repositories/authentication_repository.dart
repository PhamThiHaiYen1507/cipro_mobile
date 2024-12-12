import 'package:base_project/core/type_def/api_response_data.dart';

abstract class AuthenticationRepository {
  Future<ApiResponseData<bool>> login(String username, String password);

  Future<ApiResponseData<bool>> loginWithGithub();

  Future<ApiResponseData<bool>> handleGithubCallback(
      {String? code, String? state});

  Future<ApiResponseData<bool>> registerAccount(
      String username, String password, String confirmPassword, String email);

  Future<ApiResponseData<bool>> logout();
}
