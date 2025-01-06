import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

import 'dashboard_admin_overview/dashboard_admin_overview.dart';

class DashboardOverviewScreen extends StatelessWidget {
  final AccountRole role;

  const DashboardOverviewScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return switch (role) {
      AccountRole.admin => const DashboardAdminOverview(),
      AccountRole.manager => const SizedBox(),
      AccountRole.member => const Center(
          child: Padding(
            padding: AppPadding.a24,
            child: Text(
              'Import your projects from Github using the project selection on the topbar. If you are a member, ask your manager to add you to any project to start.',
              style: AppTextStyle.f24B,
              textAlign: TextAlign.center,
            ),
          ),
        ),
    };
  }
}
