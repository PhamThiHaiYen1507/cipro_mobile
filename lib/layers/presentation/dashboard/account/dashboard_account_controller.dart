import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_account_controller.g.dart';

class DashboardAccountController = _DashboardAccountControllerBase
    with _$DashboardAccountController;

abstract class _DashboardAccountControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;

  _DashboardAccountControllerBase(this._accountInfoRepository);

  @action
  Future<bool> deleteAccount(
      BuildContext context, AccountInfoModel? accountInfo) async {
    final res = await _accountInfoRepository
        .deleteAccount(accountInfo?.accountId ?? '');

    return res.fold((left) => false, (right) {
      context.pop();

      if (right) {
        AppDialog.showNotification(
          context: context,
          title: 'Account',
          message: 'Delete account success!',
          type: NotificationType.success,
        );
      }

      return right;
    });
  }
}
