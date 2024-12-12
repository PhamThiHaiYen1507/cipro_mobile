import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_activity_builder_controller.g.dart';

class ProjectActivityBuilderController = _ProjectActivityBuilderControllerBase
    with _$ProjectActivityBuilderController;

abstract class _ProjectActivityBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final String projectName;

  final String? username;

  _ProjectActivityBuilderControllerBase(
      this._projectInfoRepository, this.projectName, this.username) {
    _getProjectActivities();
  }

  @observable
  List<ProjectActivityInfoModel> activities = [];

  @action
  Future<void> _getProjectActivities() async {
    final res = await _projectInfoRepository.getProjectActivities(
        projectName, username);
    res.map((right) {
      if (right != null) activities = right;
    });
  }
}
