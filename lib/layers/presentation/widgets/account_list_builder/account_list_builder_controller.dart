import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/repositories/account_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'account_list_builder_controller.g.dart';

@injectable
class AccountListBuilderController = _AccountListBuilderControllerBase
    with _$AccountListBuilderController;

abstract class _AccountListBuilderControllerBase with Store {
  final AccountInfoRepository _accountInfoRepository;

  @observable
  List<AccountInfoModel> accounts = [];

  _AccountListBuilderControllerBase(this._accountInfoRepository) {
    getAccountList();
  }

  @action
  Future<void> getAccountList() async {
    final res = await _accountInfoRepository.getAccountList();

    res.map(
      (right) {
        if (right != null) accounts = right;
      },
    );
  }
}
