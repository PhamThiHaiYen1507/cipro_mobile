import 'dart:developer';

import 'package:base_project/layers/presentation/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';
part 'routes_generate.dart';

@TypedGoRoute<MainRoute>(
  path: '/',
  routes: [
    TypedGoRoute<HomeScreenRoute>(path: Routes.home),
  ],
)
@immutable
class MainRoute extends GoRouteData {}

abstract class Routes {
  static const String home = '/home';

  static GoRouter routes = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: home,
    onException: (context, state, router) {
      log('exception on router: ${state.uri.toString()}', name: 'APP_ROUTER');
    },
    routes: $mainRoute.routes,
    navigatorKey: mainNavigatorKey,
  );

  static GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey();
}
