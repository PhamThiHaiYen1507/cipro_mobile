import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'assign_task_button_controller.g.dart';

@injectable
class AssignTaskButtonController = _AssignTaskButtonControllerBase
    with _$AssignTaskButtonController;

abstract class _AssignTaskButtonControllerBase with Store {
  final TaskRepository _taskRepository;

  _AssignTaskButtonControllerBase(this._taskRepository);

  Future<bool> assignTask(String memberId, String taskId) async {
    final res =
        await _taskRepository.assignTask(taskId: taskId, memberId: memberId);

    return res.fold((fnL) => false, (r) => true);
  }
}
