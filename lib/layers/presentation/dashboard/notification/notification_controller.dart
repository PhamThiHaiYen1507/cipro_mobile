import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/data/response/notification_response.dart';
import 'package:base_project/layers/domain/repositories/notification_repository.dart';
import 'package:base_project/layers/domain/translators/notification_translator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/notification_model.dart';

part 'notification_controller.g.dart';

@injectable
class NotificationScreenController = _NotificationScreenControllerBase
    with _$NotificationScreenController;

abstract class _NotificationScreenControllerBase with Store, MobxLifeCircle {
  final NotificationRepository _notificationRepository;

  _NotificationScreenControllerBase(this._notificationRepository) {
    getNotifications();

    FirebaseMessaging.onMessage.listen((message) {
      if (message.data.isNotEmpty) {
        final data =
            NotificationResponse.fromJson(message.data).toNotificationModel();

        onReceivedNotification(data);
      }
    });
  }

  @observable
  List<NotificationModel> notifications = [];

  @action
  onReceivedNotification(NotificationModel notification) {
    notifications = [notification, ...notifications];
  }

  @action
  Future<void> getNotifications() async {
    final res = await _notificationRepository.getNotifications();

    res.map((right) {
      notifications = right;
    });
  }
}
