import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_builder_controller.g.dart';

class ProjectBuilderController = _ProjectBuilderControllerBase
    with _$ProjectBuilderController;

abstract class _ProjectBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final String? projectName;

  _ProjectBuilderControllerBase(this._projectInfoRepository, this.projectName) {
    _getProjectInfo();
  }

  @observable
  ProjectInfoModel? project;

  @action
  Future<void> _getProjectInfo() async {
    final res =
        await _projectInfoRepository.getProjectWithName(projectName ?? '');

    res.map((right) {
      if (right != null) project = right;
    });
  }
}
