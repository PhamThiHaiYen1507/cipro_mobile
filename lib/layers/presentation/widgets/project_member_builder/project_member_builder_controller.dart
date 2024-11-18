import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_member_builder_controller.g.dart';

class ProjectMemberBuilderController = _ProjectMemberBuilderControllerBase
    with _$ProjectMemberBuilderController;

abstract class _ProjectMemberBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final String projectName;

  _ProjectMemberBuilderControllerBase(
      this._projectInfoRepository, this.projectName) {
    _getProjectMembers();
  }

  @observable
  List<ProjectMemberInfoModel> members = [];

  @action
  Future<void> _getProjectMembers() async {
    final res = await _projectInfoRepository.getProjectMembers(projectName);

    res.map((right) {
      if (right != null) members = right;
    });
  }
}
