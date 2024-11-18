import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'project_list_builder_controller.g.dart';

@injectable
class ProjectListBuilderController = _ProjectListBuilderControllerBase
    with _$ProjectListBuilderController;

abstract class _ProjectListBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  _ProjectListBuilderControllerBase(this._projectInfoRepository) {
    _getProjects();
  }

  @observable
  List<ProjectInfoModel> projects = [];

  @action
  Future<void> _getProjects() async {
    final res = await _projectInfoRepository.getProjects();

    res.map((right) {
      if (right != null) projects = right;
    });
  }
}
