import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:base_project/layers/presentation/dashboard/notification/settings/notification_settings_screen.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'edit_account_controller.g.dart';

class EditAccountController = _EditAccountControllerBase
    with _$EditAccountController;

abstract class _EditAccountControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;
  final AccountInfoModel accountInfoTmp;

  _EditAccountControllerBase(this._accountInfoRepository, this.accountInfoTmp) {
    accountInfo = accountInfoTmp;
  }

  @observable
  AccountInfoModel? accountInfo;

  @action
  Future<void> editAccount(BuildContext context, Function() onSave) async {
    final res = await _accountInfoRepository.editAccount(
        accountId: accountInfoTmp.accountId, reuqest: accountInfo!);

    res.map((right) {
      context.pop();

      if (right) {
        AppDialog.showNotification(
          context: context,
          title: 'Account',
          message: 'Edit account success!',
          type: NotificationType.success,
        );
        onSave();
      }
    });
  }

  @action
  void selectRole(AccountRole role) {
    if (accountInfo != null) {
      accountInfo!.role = role;
      accountInfo = AccountInfoModel(
        accountId: accountInfo!.accountId,
        username: accountInfo!.username,
        role: role,
        email: accountInfo!.email,
        permission: accountInfo!.permission,
        thirdParty: accountInfo!.thirdParty,
        notifications:
            NotificationSettingType.values.map((e) => e.name).toList(),
      );
    }
  }
}
