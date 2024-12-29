import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'notification_settings_controller.g.dart';

@injectable
class NotificationSettingsController = _NotificationSettingsControllerBase
    with _$NotificationSettingsController;

abstract class _NotificationSettingsControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;

  final AccountManagerController _accountManager;

  _NotificationSettingsControllerBase(
      this._accountInfoRepository, this._accountManager) {
    notifications = _accountManager.accountInfo?.notifications ?? [];
  }

  @observable
  List<String> notifications = [];

  @action
  void onAddNotificationSetting(String value) {
    notifications = [...notifications, value];

    _accountManager.accountInfo?.notifications.clear();

    _accountManager.accountInfo?.notifications.addAll(notifications);

    updateAccountInfo();
  }

  @action
  void onRemoveNotificationSetting(String value) {
    notifications = notifications.where((element) => element != value).toList();

    _accountManager.accountInfo?.notifications.clear();

    _accountManager.accountInfo?.notifications.addAll(notifications);

    updateAccountInfo();
  }

  void updateAccountInfo() {
    if (_accountManager.accountInfo != null) {
      _accountInfoRepository.editAccount(
          accountId: _accountManager.accountInfo!.accountId,
          reuqest: _accountManager.accountInfo!);
    }
  }
}
