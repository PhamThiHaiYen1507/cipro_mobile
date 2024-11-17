import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthenticationRepository _authenticationRepository;

  _LoginControllerBase(this._authenticationRepository);

  Future<void> doLogin(
      BuildContext context, String username, String password) async {
    final res = await _authenticationRepository.login(username, password);

    res.fold((left) {
      AppDialog.showNotification(
        context: context,
        title: '',
        message: left.message ?? 'login failed!',
        type: NotificationType.error,
      );
    }, (right) {});
  }
}
