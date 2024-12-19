import 'package:base_project/layers/domain/entities/notification_model.dart';

import '../../../core/type_def/api_response_data.dart';

abstract class NotificationRepository {
  Future<ApiResponseData<bool>> setNotificationToken({required String token});

  Future<ApiResponseData<List<NotificationModel>>> getNotifications();
}
