import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/dashboard/dashboard_controller.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/bottom_navigation_type.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
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
              const Text('Dashboard'),
              AppSpacing.w16,
              if (widget.role != AccountRole.admin)
                Expanded(
                  child: Observer(
                    builder: (_) => SelectProjectDropdown(
                      selectedProjectName: controller.selectedProjectName,
                      onSelected: (project) {
                        controller.setSelectedProjectName(
                            context, widget.current, project.name);
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
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
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

  Future<void> logout() async {
    final res = await controller.logout();

    if (res) {
      LoginScreenRoute().go(context);
    }
  }
}
