import 'package:base_project/layers/data/response/third_party_info_response.dart';
import 'package:base_project/layers/domain/entities/third_party_info_model.dart';
import 'package:base_project/utils/utils.dart';

extension ThirdPartyInfoTranslator on ThirdPartyInfoResponse {
  ThirdPartyInfoModel toThirdPartyInfoModel() => ThirdPartyInfoModel(
        name: name,
        partyId: sId ?? Utils.generateId,
        accessToken: accessToken,
        username: username,
      );
}
