import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_script_controller.g.dart';

@injectable
class DashboardScriptController = _DashboardScriptControllerBase
    with _$DashboardScriptController;

abstract class _DashboardScriptControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  _DashboardScriptControllerBase(this._projectInfoRepository);

  void onChangedStatus(
      String projectName, String workflowId, bool status) async {
    _projectInfoRepository.changeActionStatus(
      projectName: projectName,
      workflowId: workflowId,
      status: status,
    );
  }
}
