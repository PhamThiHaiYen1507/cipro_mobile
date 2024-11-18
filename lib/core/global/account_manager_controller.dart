import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'account_manager_controller.g.dart';

@singleton
class AccountManagerController = _AccountManagerControllerBase
    with _$AccountManagerController;

abstract class _AccountManagerControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;

  _AccountManagerControllerBase(this._accountInfoRepository);

  @observable
  AccountInfoModel? accountInfo;

  @action
  Future<void> getAccountInfo() async {
    final res = await _accountInfoRepository.getAccountInfo();

    res.map((right) {
      accountInfo = right;
    });
  }
}
