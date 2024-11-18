import 'package:base_project/layers/data/response/task_info_response.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:base_project/utils/utils.dart';

extension TaskInfoTranslator on TaskInfoResponse {
  TaskInfoModel toTaskInfoModel() => TaskInfoModel(
        taskId: sId ?? Utils.generateId,
        description: description,
        dueDate: dueDate ?? DateTime.now(),
        createdAt: createdAt,
        name: name,
        status: status,
        projectName: projectName,
        updatedAt: updatedAt,
      );
}
