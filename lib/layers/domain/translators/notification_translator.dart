import 'package:base_project/layers/domain/entities/notification_model.dart';

import '../../data/response/notification_response.dart';

extension NotificationTranslator on NotificationResponse {
  NotificationModel toNotificationModel() => NotificationModel(
        title: title ?? '',
        content: content ?? '',
        createBy: createBy ?? '',
        type: type ?? 'default',
      );
}
