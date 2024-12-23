import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_task_controller.g.dart';

@injectable
class DashboardTaskController = _DashboardTaskControllerBase
    with _$DashboardTaskController;

abstract class _DashboardTaskControllerBase with Store {
  final TaskRepository _taskRepository;

  _DashboardTaskControllerBase(this._taskRepository);

  Future<void> updateStatus(String taskId, bool active) async {
    await _taskRepository.updateTask(taskId: taskId, active: active);
  }
}
