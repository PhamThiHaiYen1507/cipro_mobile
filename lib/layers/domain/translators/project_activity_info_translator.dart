import 'package:base_project/layers/data/response/project_activity_info_response.dart';
import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:base_project/utils/utils.dart';

extension ProjectActivityInfoTranslator on ProjectActivityInfoResponse {
  ProjectActivityInfoModel toProjectActivityInfoModel() {
    return ProjectActivityInfoModel(
      activityId: sId ?? Utils.generateId,
      action: action,
      content: content,
      createdAt: createdAt,
      createdBy: createdBy,
      id: id,
      projectId: projectId,
      updatedAt: updatedAt,
    );
  }
}
