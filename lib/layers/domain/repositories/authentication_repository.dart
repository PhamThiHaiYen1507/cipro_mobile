import 'package:base_project/core/type_def/api_response_data.dart';

abstract class AuthenticationRepository {
  Future<ApiResponseData<bool>> login(String username, String password);
}
