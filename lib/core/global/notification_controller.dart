import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../layers/domain/repositories/notification_repository.dart';

part 'notification_controller.g.dart';

@singleton
class NotificationController = _NotificationControllerBase
    with _$NotificationController;

abstract class _NotificationControllerBase with Store {
  final NotificationRepository _notificationRepository;

  _NotificationControllerBase(this._notificationRepository);

  Future<void> setNotificationToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      _notificationRepository.setNotificationToken(token: token);
    }
  }
}
