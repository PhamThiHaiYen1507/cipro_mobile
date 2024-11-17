import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../request/login_request.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/auth/login')
  Future<dynamic> login(
    @Body() LoginRequest request,
  );
}
