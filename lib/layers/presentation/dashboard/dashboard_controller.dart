import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/layers/domain/repositories/authentication_repository.dart';
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

  _DashboardControllerBase(
      this._accountManager, this._authenticationRepository);

  @observable
  String? selectedProjectName;

  @action
  void setSelectedProjectName(
      BuildContext context, String current, String? name) {
    selectedProjectName = name;

    context
        .go([current, if (name != null) Uri.encodeComponent(name)].join('/'));
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
