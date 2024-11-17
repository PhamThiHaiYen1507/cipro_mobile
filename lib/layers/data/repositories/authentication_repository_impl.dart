import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/request/login_request.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final ApiClient _client;

  AuthenticationRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<bool>> login(String username, String password) async {
    try {
      await _client.login(LoginRequest(username, password));

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
