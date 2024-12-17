import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'add_member_button_controller.g.dart';

@injectable
class AddMemberButtonController = _AddMemberButtonControllerBase
    with _$AddMemberButtonController;

abstract class _AddMemberButtonControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  _AddMemberButtonControllerBase(this._projectInfoRepository);

  Future<bool> onAddUserToProject(String projectName, String accountId) async {
    final res = await _projectInfoRepository.addMemberToProject(
      projectName: projectName,
      accountId: accountId,
    );

    return res.fold((fnL) => false, (fnR) => true);
  }
}
