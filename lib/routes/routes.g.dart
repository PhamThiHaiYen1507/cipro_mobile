// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainRoute,
    ];

RouteBase get $mainRoute => GoRouteData.$route(
      path: '/',
      factory: $MainRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/login',
          factory: $LoginScreenRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/account_register',
          factory: $AccountRegisterScreenRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/member_info',
          factory: $MemberInfoScreenRouteExtension._fromState,
        ),
        StatefulShellRouteData.$route(
          factory: $AppShellRouteExtension._fromState,
          branches: [
            StatefulShellBranchData.$branch(
              routes: [
                GoRouteData.$route(
                  path: '/dashboard',
                  factory: $AppDashboardScreenRouteExtension._fromState,
                  routes: [
                    ShellRouteData.$route(
                      factory: $DashboardScreenRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: ':role/overview',
                          factory:
                              $DashboardOverviewScreenRouteExtension._fromState,
                          routes: [
                            GoRouteData.$route(
                              path: ':projectName',
                              factory: $DashboardMemberOverviewRouteExtension
                                  ._fromState,
                            ),
                          ],
                        ),
                        GoRouteData.$route(
                          path: ':role/account',
                          factory:
                              $DashboardAccountScreenRouteExtension._fromState,
                        ),
                        GoRouteData.$route(
                          path: ':role/home',
                          factory: $DashboardEmptyHomeScreenRouteExtension
                              ._fromState,
                          routes: [
                            GoRouteData.$route(
                              path: ':projectName',
                              factory: $DashboardProjectHomeScreenRouteExtension
                                  ._fromState,
                            ),
                          ],
                        ),
                        GoRouteData.$route(
                          path: ':role/script',
                          factory:
                              $DashboardScriptScreenRouteExtension._fromState,
                        ),
                        GoRouteData.$route(
                          path: ':role/task',
                          factory:
                              $DashboardTaskScreenRouteExtension._fromState,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => MainRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginScreenRouteExtension on LoginScreenRoute {
  static LoginScreenRoute _fromState(GoRouterState state) => LoginScreenRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRegisterScreenRouteExtension on AccountRegisterScreenRoute {
  static AccountRegisterScreenRoute _fromState(GoRouterState state) =>
      AccountRegisterScreenRoute();

  String get location => GoRouteData.$location(
        '/account_register',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MemberInfoScreenRouteExtension on MemberInfoScreenRoute {
  static MemberInfoScreenRoute _fromState(GoRouterState state) =>
      MemberInfoScreenRoute(
        state.uri.queryParameters['member-id']!,
      );

  String get location => GoRouteData.$location(
        '/member_info',
        queryParams: {
          'member-id': memberId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

extension $AppDashboardScreenRouteExtension on AppDashboardScreenRoute {
  static AppDashboardScreenRoute _fromState(GoRouterState state) =>
      AppDashboardScreenRoute();

  String get location => GoRouteData.$location(
        '/dashboard',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardScreenRouteExtension on DashboardScreenRoute {
  static DashboardScreenRoute _fromState(GoRouterState state) =>
      DashboardScreenRoute();
}

extension $DashboardOverviewScreenRouteExtension
    on DashboardOverviewScreenRoute {
  static DashboardOverviewScreenRoute _fromState(GoRouterState state) =>
      DashboardOverviewScreenRoute(
        role: state.pathParameters['role']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/overview',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardMemberOverviewRouteExtension
    on DashboardMemberOverviewRoute {
  static DashboardMemberOverviewRoute _fromState(GoRouterState state) =>
      DashboardMemberOverviewRoute(
        role: state.pathParameters['role']!,
        projectName: state.pathParameters['projectName']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/overview/${Uri.encodeComponent(projectName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardAccountScreenRouteExtension on DashboardAccountScreenRoute {
  static DashboardAccountScreenRoute _fromState(GoRouterState state) =>
      DashboardAccountScreenRoute(
        role: state.pathParameters['role']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardEmptyHomeScreenRouteExtension
    on DashboardEmptyHomeScreenRoute {
  static DashboardEmptyHomeScreenRoute _fromState(GoRouterState state) =>
      DashboardEmptyHomeScreenRoute(
        state.pathParameters['role']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardProjectHomeScreenRouteExtension
    on DashboardProjectHomeScreenRoute {
  static DashboardProjectHomeScreenRoute _fromState(GoRouterState state) =>
      DashboardProjectHomeScreenRoute(
        role: state.pathParameters['role']!,
        projectName: state.pathParameters['projectName']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/home/${Uri.encodeComponent(projectName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DashboardScriptScreenRouteExtension on DashboardScriptScreenRoute {
  static DashboardScriptScreenRoute _fromState(GoRouterState state) =>
      DashboardScriptScreenRoute(
        role: _$AccountRoleEnumMap._$fromName(state.pathParameters['role']!),
        projectName: state.uri.queryParameters['project-name']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(_$AccountRoleEnumMap[role]!)}/script',
        queryParams: {
          'project-name': projectName,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$AccountRoleEnumMap = {
  AccountRole.admin: 'admin',
  AccountRole.manager: 'manager',
  AccountRole.member: 'member',
};

extension $DashboardTaskScreenRouteExtension on DashboardTaskScreenRoute {
  static DashboardTaskScreenRoute _fromState(GoRouterState state) =>
      DashboardTaskScreenRoute(
        role: state.pathParameters['role']!,
      );

  String get location => GoRouteData.$location(
        '/dashboard/${Uri.encodeComponent(role)}/task',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}
