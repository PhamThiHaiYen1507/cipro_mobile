import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';
import 'package:base_project/layers/domain/repositories/activity_history_repository.dart';
import 'package:mobx/mobx.dart';

part 'activity_history_builder_controller.g.dart';

class ActivityHistoryBuilderController = _ActivityHistoryBuilderControllerBase
    with _$ActivityHistoryBuilderController;

abstract class _ActivityHistoryBuilderControllerBase with Store {
  final ActivityHistoryRepository _activityHistoryRepository;

  _ActivityHistoryBuilderControllerBase(this._activityHistoryRepository) {
    _getHistories();
  }

  @observable
  List<ActivityHistoryInfoModel> histories = [];

  @action
  void _getHistories() async {
    final res = await _activityHistoryRepository.getActivityHistory();

    res.map((right) {
      if (right != null) histories = right;
    });
  }
}
