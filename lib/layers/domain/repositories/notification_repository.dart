import '../../../core/type_def/api_response_data.dart';

abstract class NotificationRepository {
  Future<ApiResponseData<bool>> setNotificationToken({required String token});
}
