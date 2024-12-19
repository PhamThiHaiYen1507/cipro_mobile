import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_list_builder_controller.g.dart';

class ProjectListBuilderController = _ProjectListBuilderControllerBase
    with _$ProjectListBuilderController;

abstract class _ProjectListBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final void Function(List<ProjectInfoModel> projects)? onInitialize;

  _ProjectListBuilderControllerBase(
      this._projectInfoRepository, this.onInitialize) {
    getProjects();
  }

  @observable
  List<ProjectInfoModel> projects = [];

  @action
  Future<void> getProjects() async {
    final res = await _projectInfoRepository.getProjects();

    res.map((right) {
      if (right != null) {
        projects = right;

        onInitialize?.call(right);
      }
    });
  }
}
