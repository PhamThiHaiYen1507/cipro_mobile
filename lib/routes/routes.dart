import 'dart:developer';

import 'package:base_project/layers/presentation/dashboard/account/dashboard_account_screen.dart';
import 'package:base_project/layers/presentation/dashboard/dashboard_screen.dart';
import 'package:base_project/layers/presentation/dashboard/home/dashboard_empty_home_screen/dashboard_empty_home_screen.dart';
import 'package:base_project/layers/presentation/dashboard/home/dashboard_project_home_screen/dashboard_project_home_screen.dart';
import 'package:base_project/layers/presentation/dashboard/member_info/member_info_screen.dart';
import 'package:base_project/layers/presentation/dashboard/overview/dashboard_member_overview/dashboard_member_overview.dart';
import 'package:base_project/layers/presentation/dashboard/overview/dashboard_overview_screen.dart';
import 'package:base_project/layers/presentation/dashboard/phase/dashboard_phase_screen.dart';
import 'package:base_project/layers/presentation/dashboard/phase/phase_detail/phase_detail_screen.dart';
import 'package:base_project/layers/presentation/dashboard/script/dashboard_script_screen.dart';
import 'package:base_project/layers/presentation/dashboard/task/dashboard_task_screen.dart';
import 'package:base_project/layers/presentation/dashboard/ticket/dashboard_ticket_screen.dart';
import 'package:base_project/layers/presentation/dashboard/vulnerabilities/dashboard_vulnerabilities_screen.dart';
import 'package:base_project/layers/presentation/login/login_screen.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/enum/bottom_navigation_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layers/presentation/account_register/account_register_screen.dart';
import '../layers/presentation/dashboard/notification/notification_screen.dart';
import '../layers/presentation/dashboard/notification/settings/notification_settings_screen.dart';
import '../layers/presentation/dashboard/script/guide/guide.dart';
import '../layers/presentation/dashboard/template/dashboard_template_screen.dart';
import '../layers/presentation/dashboard/ticket/ticket_detail/ticket_detail_screen.dart';

part 'routes.g.dart';
part 'routes_generate.dart';

@TypedGoRoute<MainRoute>(
  path: '/',
  routes: [
    TypedGoRoute<LoginScreenRoute>(path: Routes.login),
    TypedGoRoute<AccountRegisterScreenRoute>(path: Routes.accountRegister),
    TypedGoRoute<MemberInfoScreenRoute>(path: Routes.memberInfo),
    TypedGoRoute<PhaseDetailScreenRoute>(path: Routes.phaseDetail),
    TypedGoRoute<TicketDetailScreenRoute>(path: Routes.ticketDetail),
    TypedGoRoute<ScripGuideScreenRoute>(path: Routes.scriptGuide),
    TypedGoRoute<NotificationSettingsScreenRoute>(
        path: Routes.notificationSettings),
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
                    TypedGoRoute<DashboardEmptyPhaseScreenRoute>(
                        path: ':role${Routes.phase}',
                        routes: [
                          TypedGoRoute<DashboardPhaseScreenRoute>(
                              path: ':projectName'),
                        ]),
                    TypedGoRoute<DashboardTicketScreenRoute>(
                        path: ':role${Routes.ticket}'),
                    TypedGoRoute<DashboardVulnerabilitiesScreenRoute>(
                        path: ':role${Routes.vulnerability}'),
                    TypedGoRoute<DashboardTemplateScreenRoute>(
                        path: ':role${Routes.template}'),
                    TypedGoRoute<DashboardNotificationScreenRoute>(
                        path: ':role${Routes.notification}'),
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
  static const String phase = '/phase';
  static const String phaseDetail = '/phase_detail';
  static const String ticket = '/ticket';
  static const String vulnerability = '/vulnerability';
  static const String ticketDetail = '/ticket_detail';
  static const String template = '/template';
  static const String notification = '/notification';
  static const String scriptGuide = '/script_guide';
  static const String notificationSettings = '/notification_settings';

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
