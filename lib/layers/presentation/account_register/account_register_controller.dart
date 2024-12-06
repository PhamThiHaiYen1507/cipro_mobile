import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'account_register_controller.g.dart';

@injectable
class AccountRegisterController = _AccountRegisterControllerBase
    with _$AccountRegisterController;

abstract class _AccountRegisterControllerBase with Store {
  final AuthenticationRepository _authenticationRepository;

  _AccountRegisterControllerBase(this._authenticationRepository);

  Future<void> onRegisterAccount(BuildContext context, String username,
      String password, String confirmPassword, String email) async {
    
    
    final res = await _authenticationRepository.registerAccount(
        username, password, confirmPassword, email);

    res.fold((left) {
      AppDialog.showNotification(
        context: context,
        title: '',
        message: left.message ?? 'register account failed!',
        type: NotificationType.error,
      );
    }, (right) {
      LoginScreenRoute().go(context);

      AppDialog.showNotification(
        context: context,
        title: '',
        message: 'register account success!',
        type: NotificationType.success,
      );
    });
  }
}
