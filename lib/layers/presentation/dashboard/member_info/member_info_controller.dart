import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/repositories/task_repository.dart';

part 'member_info_controller.g.dart';

@injectable
class MemberInfoController = _MemberInfoControllerBase
    with _$MemberInfoController;

abstract class _MemberInfoControllerBase with Store {
  final TaskRepository _taskRepository;

  _MemberInfoControllerBase(this._taskRepository);

  Future<void> updateStatus(String taskId, bool active) async {
    await _taskRepository.updateTask(taskId: taskId, active: active);
  }
}
