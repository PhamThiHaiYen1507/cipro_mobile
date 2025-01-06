import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'delete_member_project_button_controller.g.dart';

@injectable
class DeleteMemberProjectButtonController = _DeleteMemberProjectButtonControllerBase
    with _$DeleteMemberProjectButtonController;

abstract class _DeleteMemberProjectButtonControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  _DeleteMemberProjectButtonControllerBase(this._projectInfoRepository);

  Future<void> removeMember(String projectName, String accountId) async {
    await _projectInfoRepository.removeMemberFromProject(
        projectName: projectName, accountId: accountId);
  }
}
