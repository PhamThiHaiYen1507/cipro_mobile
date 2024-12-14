import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'add_task_phase_button_controller.g.dart';

@injectable
class AddTaskPhaseButtonController = _AddTaskPhaseButtonControllerBase
    with _$AddTaskPhaseButtonController;

abstract class _AddTaskPhaseButtonControllerBase with Store {
  final TaskRepository _taskRepository;

  _AddTaskPhaseButtonControllerBase(this._taskRepository);

  Future<bool> addTaskToPhase(String phaseId, String taskId) async {
    final res =
        await _taskRepository.addTaskToPhase(phaseId: phaseId, taskId: taskId);

    return res.fold((left) => false, (right) => true);
  }
}
