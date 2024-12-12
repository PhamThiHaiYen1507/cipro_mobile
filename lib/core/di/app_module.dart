import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/global/deeplink_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:injectable/injectable.dart';

import '../global/notification_controller.dart';

@module
abstract class AppModule {
  @preResolve
  Future<List<dynamic>> createGlobalControllers(
    NotificationController notificationController,
    DeeplinkController deeplinkController,
    AccountManagerController accountManagerController,
  ) async {
    final controllers = [
      notificationController,
      deeplinkController,
      accountManagerController,
    ];
    MobxManager.createControllers(controllers);

    return controllers;
  }
}
