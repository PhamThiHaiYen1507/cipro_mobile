import 'package:base_project/layers/data/response/project_info_response.dart';
import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/translators/phase_translator.dart';
import 'package:base_project/utils/utils.dart';

extension ProjectInfoTranslator on ProjectInfoResponse {
  ProjectInfoModel toProjectInfoModel() => ProjectInfoModel(
        projectId: sId ?? Utils.generateId,
        name: name ?? '',
        createdBy: createdBy,
        phaseList: phaseList?.map((e) => e.toPhaseModel()).toList() ?? [],
        status: status,
        url: url,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
