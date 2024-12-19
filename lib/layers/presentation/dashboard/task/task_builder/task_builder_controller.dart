import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:mobx/mobx.dart';

part 'task_builder_controller.g.dart';

class TaskBuilderController = _TaskBuilderControllerBase
    with _$TaskBuilderController;

abstract class _TaskBuilderControllerBase with Store {
  final TaskRepository _taskRepository;

  final String projectName;

  final String? filter;

  _TaskBuilderControllerBase(
      this._taskRepository, this.projectName, this.filter) {
    getTasks();
  }

  @observable
  List<TaskInfoModel> tasks = [];

  @action
  Future<void> getTasks() async {
    final res = await _taskRepository.getTasks(
        projectName: projectName, filter: filter);

    res.map((right) {
      tasks = right;
    });
  }
}
