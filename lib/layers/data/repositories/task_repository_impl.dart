import 'package:base_project/core/extensions/base_response_extension.dart';
import 'package:base_project/core/extensions/exception_extension.dart';
import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/data/response/task_info_response.dart';
import 'package:base_project/layers/data/source/api_client.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:base_project/layers/domain/translators/task_info_translator.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _client;

  TaskRepositoryImpl(this._client);

  @override
  Future<ApiResponseData<bool>> createNewTask({
    required String projectName,
    required String name,
    required String description,
    required DateTime dueDate,
    required String phaseId,
    required String assigneeId,
  }) async {
    try {
      await _client.createNewTask({
        'assigneeId': assigneeId,
        'phaseId': phaseId,
        'data': {
          'projectName': projectName,
          'name': name,
          'description': description,
          'dueDate': dueDate.toIso8601String(),
        }
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> addTaskToPhase(
      {required String phaseId, required String taskId}) async {
    try {
      await _client.addTaskToPhase(phaseId, taskId);

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<List<TaskInfoModel>>> getTasks(
      {required String projectName, String? filter}) async {
    try {
      final res =
          await _client.getTasks(projectName: projectName, filter: filter);

      return Right(res
              .getItems(TaskInfoResponse.fromJson)
              ?.map((e) => e.toTaskInfoModel())
              .toList() ??
          []);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> deleteTask(
      {required String taskId, required String phaseId}) async {
    try {
      await _client.deleteTask(phaseId, taskId);

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> updateTask(
      {required String taskId, required bool active}) async {
    try {
      await _client.updateTask(taskId, {
        'data': {'status': active ? 'active' : 'completed'}
      });

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }

  @override
  Future<ApiResponseData<bool>> assignTask(
      {required String taskId, required String memberId}) async {
    try {
      await _client.assignTask(memberId, taskId);

      return const Right(true);
    } on Exception catch (e, stackTrace) {
      return Left(e.handlerApiException(stackTrace));
    }
  }
}
