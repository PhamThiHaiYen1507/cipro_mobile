import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/repositories/notification_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../source/api_client.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final ApiClient _client;

  NotificationRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<bool>> setNotificationToken(
      {required String token}) async {
    try {
      await _client.setNotificationToken({'token': token});

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
