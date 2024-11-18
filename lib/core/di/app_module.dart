import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/global/deeplink_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  Future<List<dynamic>> createGlobalControllers(
    DeeplinkController deeplinkController,
    AccountManagerController accountManagerController,
  ) async {
    final controllers = [
      deeplinkController,
      accountManagerController,
    ];

    MobxManager.createControllers(controllers);

    return controllers;
  }
}
