import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';

abstract class TaskRepository {
  Future<ApiResponseData<bool>> createNewTask({
    required String projectName,
    required String name,
    required String description,
    required DateTime dueDate,
  });

  Future<ApiResponseData<bool>> addTaskToPhase({
    required String phaseId,
    required String taskId,
  });

  Future<ApiResponseData<List<TaskInfoModel>>> getTasks({
    required String projectName,
    String? filter,
  });
}
