import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:mobx/mobx.dart';

part 'phase_detail_controller.g.dart';

class PhaseDetailController = _PhaseDetailControllerBase
    with _$PhaseDetailController;

abstract class _PhaseDetailControllerBase with Store {
  final TaskRepository _taskRepository;

  final String phaseId;

  _PhaseDetailControllerBase(this._taskRepository, this.phaseId);

  @observable
  List<String> taskIds = [];

  @action
  void addSelectedTask(String taskId) {
    taskIds = [...taskIds, taskId];
  }

  @action
  void removeSelectedTask(String taskId) {
    taskIds = taskIds.where((e) => e != taskId).toList();
  }

  @action
  void onChandedSelectedTask(bool isChecked, String taskId) {
    if (isChecked) {
      addSelectedTask(taskId);
    } else {
      removeSelectedTask(taskId);
    }
  }

  Future<void> onRemoveSelectedTask() async {
    await Future.wait(taskIds
        .map((e) => _taskRepository.deleteTask(taskId: e, phaseId: phaseId)));
  }
}
