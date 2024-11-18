import 'package:base_project/layers/domain/entities/workflow_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_workflow_list_builder_controller.g.dart';

class ProjectWorkflowListBuilderController = _ProjectWorkflowListBuilderControllerBase
    with _$ProjectWorkflowListBuilderController;

abstract class _ProjectWorkflowListBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final String projectName;

  _ProjectWorkflowListBuilderControllerBase(
      this._projectInfoRepository, this.projectName) {
    _getWorkflows();
  }

  @observable
  List<WorkflowInfoModel> workflows = [];

  @action
  Future<void> _getWorkflows() async {
    final res = await _projectInfoRepository.getProjectWorkflows(projectName);

    res.map((right) {
      if (right != null) workflows = right;
    });
  }
}
