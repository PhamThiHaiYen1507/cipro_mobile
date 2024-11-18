import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:mobx/mobx.dart';

part 'project_member_info_builder_controller.g.dart';

class ProjectMemberInfoBuilderController = _ProjectMemberInfoBuilderControllerBase
    with _$ProjectMemberInfoBuilderController;

abstract class _ProjectMemberInfoBuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  final String? memberId;

  final String? accountId;

  _ProjectMemberInfoBuilderControllerBase(
      this._projectInfoRepository, this.memberId, this.accountId) {
    _getProjectMemberFromId();
  }

  @observable
  ProjectMemberInfoModel? member;

  @action
  Future<void> _getProjectMemberFromId() async {
    final res = await _projectInfoRepository.getProjectMemberFromId(
      memberId: memberId,
      accountId: accountId,
    );

    res.map((right) {
      if (right != null) member = right;
    });
  }
}
