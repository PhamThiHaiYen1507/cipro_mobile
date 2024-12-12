import 'dart:ui';

import 'package:base_project/routes/routes.dart';
import 'package:collection/collection.dart';

enum AccountRole {
  admin(Routes.overview, Color(0xff6366F1)),
  manager(Routes.home, Color(0xff9c27b0)),
  member(Routes.overview, Color(0xff10B981));

  factory AccountRole.from(String? value) =>
      AccountRole.values.firstWhereOrNull((element) => element.name == value) ??
      AccountRole.member;

  String dashboardRoute(String route) => '/dashboard/$name$route';

  final String home;

  final Color color;

  const AccountRole(this.home, this.color);

  String get homeRoute => dashboardRoute(home);
}
