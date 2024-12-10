import 'package:base_project/app/builder/app_loading_builder_controller.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/global/deeplink_controller.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthenticationRepository _authenticationRepository;

  final DeeplinkController _deeplinkController;

  final AccountManagerController _accountManager;

  final Debouncer _debouncer = Debouncer(waitForMs: 500);

  Set<String?> previousLink = {null};

  _LoginControllerBase(
    this._authenticationRepository,
    this._deeplinkController,
    this._accountManager,
  ) {
    autorun((_) {
      if (_deeplinkController.deeplink != null &&
          !previousLink.contains(_deeplinkController.deeplink?.toString())) {
        previousLink.add(_deeplinkController.deeplink?.toString());
        _onDeeplinkChanged(_deeplinkController.deeplink);
      }
    });
  }

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
    }, (right) async {
      await _accountManager.getAccountInfo();

      if (_accountManager.accountInfo != null) {
        context.go(_accountManager.accountInfo!.role.homeRoute);
      }
    });
  }

  Future<void> doLoginWithGithub() async {
    await _authenticationRepository.loginWithGithub();
  }

  Future<void> _onDeeplinkChanged(Uri? link) async {
    _deeplinkController.deeplink = null;
    if (link?.scheme == 'doan' && link?.queryParameters['code'] != null) {
      _debouncer.debouncing(fn: () async {
        LoadingOverlay.show();
        final res = await _authenticationRepository.handleGithubCallback(
          code: link!.queryParameters['code'],
          state: link.queryParameters['state'],
        );
        LoadingOverlay.close();

        res.fold((left) {
          AppDialog.showNotification(
            context: Routes.mainNavigatorKey.currentContext!,
            title: '',
            message: left.message ?? 'login failed!',
            type: NotificationType.error,
          );
        }, (right) async {
          await _accountManager.getAccountInfo();

          if (_accountManager.accountInfo != null) {
            Routes.routes.go(_accountManager.accountInfo!.role.homeRoute);
          }
        });
      });
    }
  }
}
