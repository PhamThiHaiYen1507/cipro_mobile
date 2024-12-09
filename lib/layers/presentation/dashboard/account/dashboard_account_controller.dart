import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_account_controller.g.dart';

@injectable
class DashboardAccountController = _DashboardAccountControllerBase
    with _$DashboardAccountController;

abstract class _DashboardAccountControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;

  _DashboardAccountControllerBase(this._accountInfoRepository);

  @observable
  AccountInfoModel? accountInfo;

  @action
  Future<void> editAccount(BuildContext context) async {
    final res = await _accountInfoRepository.editAccount(
        accountId: accountInfo?.accountId ?? '', reuqest: accountInfo!);

    res.map((right) {
      AppDialog.showNotification(
        context: context,
        title: 'Account',
        message: 'Edit account success!',
        type: NotificationType.success,
      );
    });
  }

  @action
  Future<void> deleteAccount(BuildContext context) async {
    final res = await _accountInfoRepository
        .deleteAccount(accountInfo?.accountId ?? '');

    res.map((right) {
      AppDialog.showNotification(
        context: context,
        title: 'Account',
        message: 'Delete account success!',
        type: NotificationType.success,
      );
    });
  }

  @action
  void selectRole(AccountRole role) {
    if (accountInfo != null) {
      accountInfo!.role = role;
      accountInfo = AccountInfoModel.fromJson(accountInfo!.toJson());
    }
  }
}
