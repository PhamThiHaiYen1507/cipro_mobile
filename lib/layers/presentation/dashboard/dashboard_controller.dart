import 'package:base_project/app/builder/app_loading_builder_controller.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
import 'package:base_project/layers/domain/repositories/project_info_repository.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/select_project_dropdown/import_project_dialog.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
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
  Future<void> setSelectedProjectName(BuildContext context, String current,
      String? name, String? projectId) async {
    if (projectId != '-1') {
      selectedProjectName = name;

      context
          .go([current, if (name != null) Uri.encodeComponent(name)].join('/'));
    } else {
      LoadingOverlay.show();
      final res = await _projectInfoRepository.getProjectFromThirdParties();
      LoadingOverlay.close();
      AppDialog.dialog(
          context: context,
          content: ImportProjectDialog(
            projects: res.right ?? [],
            selectedProject: selectedProjectImport,
            onSelected: (project) => selectedProjectImport = project,
            onCancel: () => context.pop(),
            onImport: () {
              if (selectedProjectImport != null) {}
              context.pop();
            },
          ));
    }
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
}
