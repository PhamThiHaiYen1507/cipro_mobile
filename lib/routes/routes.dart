import 'dart:developer';

import 'package:base_project/layers/presentation/dashboard/account/dashboard_account_screen.dart';
import 'package:base_project/layers/presentation/dashboard/dashboard_screen.dart';
import 'package:base_project/layers/presentation/dashboard/home/dashboard_empty_home_screen/dashboard_empty_home_screen.dart';
import 'package:base_project/layers/presentation/dashboard/home/dashboard_project_home_screen/dashboard_project_home_screen.dart';
import 'package:base_project/layers/presentation/dashboard/member_info/member_info_screen.dart';
import 'package:base_project/layers/presentation/dashboard/overview/dashboard_member_overview/dashboard_member_overview.dart';
import 'package:base_project/layers/presentation/dashboard/overview/dashboard_overview_screen.dart';
import 'package:base_project/layers/presentation/dashboard/script/dashboard_script_screen.dart';
import 'package:base_project/layers/presentation/dashboard/task/dashboard_task_screen.dart';
import 'package:base_project/layers/presentation/login/login_screen.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/bottom_navigation_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layers/presentation/account_register/account_register_screen.dart';

part 'routes.g.dart';
part 'routes_generate.dart';

@TypedGoRoute<MainRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginScreenRoute>(path: Routes.login),
    TypedGoRoute<AccountRegisterScreenRoute>(path: Routes.accountRegister),
    TypedGoRoute<MemberInfoScreenRoute>(path: Routes.memberInfo),
    TypedStatefulShellRoute<AppShellRoute>(
      branches: [
        TypedStatefulShellBranch<AdminBranch>(
          routes: [
            TypedGoRoute<AppDashboardScreenRoute>(
                path: Routes.dashboard,
                routes: [
                  TypedShellRoute<DashboardScreenRoute>(routes: [
                    TypedGoRoute<DashboardOverviewScreenRoute>(
                        path: ':role${Routes.overview}',
                        routes: [
                          TypedGoRoute<DashboardMemberOverviewRoute>(
                              path: ':projectName'),
                        ]),
                    TypedGoRoute<DashboardAccountScreenRoute>(
                        path: ':role${Routes.account}'),
                    TypedGoRoute<DashboardEmptyHomeScreenRoute>(
                        path: ':role${Routes.home}',
                        routes: [
                          TypedGoRoute<DashboardProjectHomeScreenRoute>(
                              path: ':projectName'),
                        ]),
                    TypedGoRoute<DashboardScriptScreenRoute>(
                        path: ':role${Routes.script}'),
                    TypedGoRoute<DashboardTaskScreenRoute>(
                        path: ':role${Routes.task}'),
                  ]),
                ])
          ],
        ),
      ],
    ),
  ],
)
@immutable
class MainRoute extends GoRouteData {}

abstract class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String accountRegister = '/account_register';
  static const String overview = '/overview';
  static const String account = '/account';
  static const String dashboard = '/dashboard';
  static const String memberInfo = '/member_info';
  static const String script = '/script';
  static const String task = '/task';

  static GoRouter routes = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: login,
    onException: (context, state, router) {
      log('exception on router: ${state.uri.toString()}', name: 'APP_ROUTER');
    },
    routes: $mainRoute.routes,
    navigatorKey: mainNavigatorKey,
  );

  static GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey();

  static String get currentRoute {
    final RouteMatch lastMatch =
        Routes.routes.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : Routes.routes.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
