import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_from_thirdparty_model.dart';
import 'package:base_project/layers/presentation/dashboard/dashboard_controller.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/select_project_dropdown/import_project_dialog.dart';
import 'package:base_project/layers/presentation/widgets/project_list_builder/project_list_builder_controller.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/bottom_navigation_type.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'widgets/select_project_dropdown/select_project_dropdown.dart';

class DashboardScreen extends MobxStatefulWidget<DashboardController> {
  final Widget child;

  final String current;

  final AccountRole role;

  final List<BottomNavigationType> navItems;

  const DashboardScreen({
    super.key,
    required this.child,
    required this.current,
    required this.role,
    required this.navItems,
  });

  @override
  MobxState<MobxStatefulWidget<DashboardController>, DashboardController>
      createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends MobxState<DashboardScreen, DashboardController> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navItems.indexWhere((element) =>
        widget.current.startsWith(controller.dashboardRoute(element.route)));

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          title: Row(
            children: [
              if (widget.role != AccountRole.admin)
                Expanded(
                  child: Observer(
                    builder: (_) => SelectProjectDropdown(
                      role: widget.role,
                      selectedProjectName: controller.selectedProjectName,
                      onSelected: (project) async {
                        if (project.projectId != '-1') {
                          controller.setSelectedProjectName(
                              context, widget.current, project.name);
                        } else {
                          final res = await controller.getRepoGithub();
                          res != null
                              ? AppDialog.dialog(
                                  context: context,
                                  content: Observer(
                                    builder: (_) => ImportProjectDialog(
                                      projects: res,
                                      selectedProject:
                                          controller.selectedProjectImport,
                                      onSelected: (project) => controller
                                          .selectedProjectImport = project,
                                      onCancel: () => context.pop(),
                                      onImport: () {
                                        if (controller.selectedProjectImport !=
                                            null) {
                                          onImport(controller
                                              .selectedProjectImport!);
                                        }
                                        context.pop();
                                      },
                                    ),
                                  ),
                                )
                              : null;
                        }
                      },
                    ),
                  ),
                )
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: logout,
            )
          ],
        ),
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex >= 0 ? currentIndex : 0,
          onTap: (i) =>
              context.go(controller.dashboardRoute(widget.navItems[i].route)),
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.black,
          selectedFontSize: 14,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          iconSize: 28,
          items: widget.navItems
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.title,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Future<void> onImport(ProjectFromThirdPartyModel selectedProject) async {
    final res = await controller.importProject();

    if (res) {
      MobxManager.get<ProjectListBuilderController>().getProjects();

      AppDialog.showNotification(
        context: context,
        title: 'Import project',
        message: 'Import project success',
        type: NotificationType.success,
      );
    } else {
      AppDialog.showNotification(
        context: context,
        title: 'Import project',
        message: 'Import project failed',
        type: NotificationType.error,
      );
    }
  }

  Future<void> logout() async {
    final res = await controller.logout();

    if (res) {
      LoginScreenRoute().go(context);
    }
  }
}
