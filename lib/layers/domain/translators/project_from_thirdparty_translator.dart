import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';

extension ProjectFromThirdPartyTranslator on ProjectFromThirdPartyModel {
  ProjectFromThirdPartyModel toProjectFromThirdPartyModel() =>
      ProjectFromThirdPartyModel(
          name: name, url: url, owner: owner, status: status);
}
