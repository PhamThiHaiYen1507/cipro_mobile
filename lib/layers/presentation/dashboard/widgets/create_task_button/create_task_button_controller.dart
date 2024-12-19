import 'package:base_project/layers/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'create_task_button_controller.g.dart';

@injectable
class CreateTaskButtonController = _CreateTaskButtonControllerBase
    with _$CreateTaskButtonController;

abstract class _CreateTaskButtonControllerBase with Store {
  final TaskRepository _taskRepository;

  _CreateTaskButtonControllerBase(this._taskRepository);

  Future<bool> createNewTask({
    required String projectName,
    required String name,
    required String description,
    required DateTime dueDate,
  }) async {
    final res = await _taskRepository.createNewTask(
        projectName: projectName,
        name: name,
        description: description,
        dueDate: dueDate);

    return res.fold((left) => false, (right) => true);
  }
}
