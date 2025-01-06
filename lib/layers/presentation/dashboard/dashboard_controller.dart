import 'package:base_project/app/builder/app_loading_builder_controller.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/logger/logger.dart';
import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:base_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_controller.g.dart';

@injectable
class DashboardController = _DashboardControllerBase with _$DashboardController;

abstract class _DashboardControllerBase with Store {
  final AccountManagerController _accountManager;

  final AuthenticationRepository _authenticationRepository;

  final ProjectInfoRepository _projectInfoRepository;

  _DashboardControllerBase(this._accountManager, this._authenticationRepository,
      this._projectInfoRepository);

  @observable
  String? selectedProjectName;

  @observable
  ProjectFromThirdPartyModel? selectedProjectImport;

  @action
  Future<void> setSelectedProjectName(
      BuildContext context, String current, String? name) async {
    selectedProjectName = name;

    logD(current);

    final route = '/${current.split('/')[3]}';

    context.go(dashboardRoute(route));
  }

  Future<List<ProjectFromThirdPartyModel>?> getRepoGithub() async {
    LoadingOverlay.show();
    final res = await _projectInfoRepository.getProjectFromThirdParties();
    LoadingOverlay.close();
    return res.fold((left) => null, (right) => right);
  }

  String dashboardRoute(String route) {
    switch (route) {
      case Routes.home:
      case Routes.overview:
      case Routes.phase:
        return (_accountManager.accountInfo?.role.dashboardRoute(route) ??
                '/') +
            (selectedProjectName != null
                ? '/${Uri.encodeComponent(selectedProjectName ?? '')}'
                : '');
      default:
        return Uri.parse(
                _accountManager.accountInfo?.role.dashboardRoute(route) ?? '/')
            .replace(queryParameters: {
          if (selectedProjectName != null) 'project-name': selectedProjectName
        }).toString();
    }
  }

  Future<bool> logout() async {
    final res = await _authenticationRepository.logout();

    return res.fold((left) => false, (right) => true);
  }

  Future<bool> importProject() async {
    final res = await _projectInfoRepository.importProject(
      name: selectedProjectImport?.name,
      owner: selectedProjectImport?.owner,
      status: selectedProjectImport?.status,
      url: selectedProjectImport?.url,
    );

    return res.fold((left) => false, (right) {
      return true;
    });
  }
}
