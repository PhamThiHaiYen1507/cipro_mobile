part of 'routes.dart';

class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return navigationShell;
  }
}

class AdminBranch extends StatefulShellBranchData {
  const AdminBranch();
}

class ManagerBanch extends StatefulShellBranchData {
  const ManagerBanch();
}

class UserBranch extends StatefulShellBranchData {
  const UserBranch();
}

@immutable
class DashboardScreenRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    final role = AccountRole.from(state.pathParameters['role']);

    return DashboardScreen(
      current: Routes.currentRoute,
      role: role,
      navItems: switch (role) {
        AccountRole.admin => [
            BottomNavigationType.overview,
            BottomNavigationType.account,
            BottomNavigationType.template,
            BottomNavigationType.scanningTool,
          ],
        AccountRole.manager => [
            BottomNavigationType.home,
            BottomNavigationType.phase,
            BottomNavigationType.script,
            BottomNavigationType.ticket,
            BottomNavigationType.vulnerability,
            BottomNavigationType.notification,
          ],
        AccountRole.member => [
            BottomNavigationType.overview,
            BottomNavigationType.ticket,
            BottomNavigationType.task,
            BottomNavigationType.vulnerability,
            BottomNavigationType.notification,
          ]
      },
      child: navigator,
    );
  }
}

@immutable
class AppDashboardScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox();
  }
}

@immutable
class DashboardProjectHomeScreenRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardProjectHomeScreenRoute(
      {required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: DashboardProjectHomeScreen(
        key: ValueKey(projectName),
        role: AccountRole.from(role),
        projectName: projectName,
      ),
    );
  }
}

@immutable
class DashboardMemberOverviewRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardMemberOverviewRoute(
      {required this.role, this.projectName = ''});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DashboardMemberOverview(projectName: projectName);
  }
}

@immutable
class DashboardEmptyHomeScreenRoute extends GoRouteData {
  final String role;

  const DashboardEmptyHomeScreenRoute(this.role);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardEmptyHomeScreen();
  }
}

@immutable
class LoginScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@immutable
class AccountRegisterScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountRegisterScreen();
  }
}

@immutable
class MemberInfoScreenRoute extends GoRouteData {
  final String memberId;

  final String projectName;

  const MemberInfoScreenRoute(this.memberId, this.projectName);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MemberInfoScreen(
      memberId: memberId,
      projectName: projectName,
    );
  }
}

@immutable
class DashboardOverviewScreenRoute extends GoRouteData {
  final String role;

  const DashboardOverviewScreenRoute({required this.role});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
        context: context,
        state: state,
        child: DashboardOverviewScreen(role: AccountRole.from(role)));
  }
}

@immutable
class DashboardScriptScreenRoute extends GoRouteData {
  final AccountRole role;

  final String projectName;

  const DashboardScriptScreenRoute({required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: DashboardScriptScreen(
        key: ValueKey(projectName),
        projectName: projectName,
      ),
    );
  }
}

@immutable
class DashboardAccountScreenRoute extends GoRouteData {
  final String role;

  const DashboardAccountScreenRoute({required this.role});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
        context: context,
        state: state,
        child: DashboardAccountScreen(role: AccountRole.from(role)));
  }
}

@immutable
class DashboardTaskScreenRoute extends GoRouteData {
  final String role;

  const DashboardTaskScreenRoute({required this.role});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: const DashboardTaskScreen(),
    );
  }
}

@immutable
class DashboardEmptyPhaseScreenRoute extends GoRouteData {
  final String role;

  const DashboardEmptyPhaseScreenRoute(this.role);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardEmptyHomeScreen();
  }
}

@immutable
class DashboardPhaseScreenRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardPhaseScreenRoute({required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: DashboardPhaseScreen(
        key: ValueKey(projectName),
        projectName: projectName,
      ),
    );
  }
}

@immutable
class PhaseDetailScreenRoute extends GoRouteData {
  final String projectName;

  final String phaseId;

  const PhaseDetailScreenRoute(
      {required this.phaseId, required this.projectName});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PhaseDetailScreen(
      phaseId: phaseId,
      projectName: projectName,
    );
  }
}

@immutable
class TicketDetailScreenRoute extends GoRouteData {
  final String projectName;

  final String ticketId;

  const TicketDetailScreenRoute(
      {required this.ticketId, required this.projectName});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketDetailScreen(
      ticketId: ticketId,
      projectName: projectName,
    );
  }
}

@immutable
class DashboardTicketScreenRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardTicketScreenRoute({required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: DashboardTicketScreen(
        key: ValueKey(projectName),
        projectName: projectName,
      ),
    );
  }
}

@immutable
class DashboardVulnerabilitiesScreenRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardVulnerabilitiesScreenRoute(
      {required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: DashboardVulnerabilitiesScreen(
        key: ValueKey(projectName),
        projectName: projectName,
      ),
    );
  }
}

@immutable
class DashboardTemplateScreenRoute extends GoRouteData {
  final String role;

  final String projectName;

  const DashboardTemplateScreenRoute(
      {required this.role, this.projectName = ''});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: const DashboardTemplateScreen(),
    );
  }
}

@immutable
class DashboardNotificationScreenRoute extends GoRouteData {
  final String role;

  const DashboardNotificationScreenRoute({required this.role});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: const DashboardNotificationScreen(),
    );
  }
}

@immutable
class ScripGuideScreenRoute extends GoRouteData {
  final String type;

  const ScripGuideScreenRoute({required this.type});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: ScripGuideScreen(
        type: GuideType.from(type),
      ),
    );
  }
}

@immutable
class NotificationSettingsScreenRoute extends GoRouteData {
  const NotificationSettingsScreenRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: const NotificationSettingsScreen(),
    );
  }
}

@immutable
class ScriptDetailScreenRoute extends GoRouteData {
  final String workflowId;

  final String projectName;

  const ScriptDetailScreenRoute(
      {required this.workflowId, required this.projectName});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _buildPageWithFadeTransition(
      context: context,
      state: state,
      child: ScriptDetailScreen(
        projectName: projectName,
        workflowId: workflowId,
      ),
    );
  }
}

CustomTransitionPage _buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    name: state.path,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
