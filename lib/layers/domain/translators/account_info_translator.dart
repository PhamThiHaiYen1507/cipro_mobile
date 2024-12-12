import 'package:base_project/layers/data/response/account_info_response.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/domain/translators/third_party_info_translator.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/utils.dart';

extension AccountInfoTranslator on AccountInfoResponse {
  AccountInfoModel toAccountInfoModel() => AccountInfoModel(
        accountId: sId ?? Utils.generateId,
        username: username ?? '',
        email: email ?? '',
        role: AccountRole.from(role),
        permission: permission ?? [],
        thirdParty:
            thirdParty?.map((e) => e.toThirdPartyInfoModel()).toList() ?? [],
      );
}
