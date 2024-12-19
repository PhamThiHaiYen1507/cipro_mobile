import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'all_user_builder_controller.g.dart';

@injectable
class AllUserbuilderController = _AllUserbuilderControllerBase
    with _$AllUserbuilderController;

abstract class _AllUserbuilderControllerBase with Store {
  final ProjectInfoRepository _projectInfoRepository;

  @observable
  List<ProjectMemberInfoModel> users = [];

  _AllUserbuilderControllerBase(this._projectInfoRepository) {
    getUsers();
  }

  @action
  Future<void> getUsers() async {
    final res = await _projectInfoRepository.getAllUser();

    res.map((right) {
      users = right;
    });
  }
}
