import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

class DashboardEmptyHomeScreen extends StatelessWidget {
  const DashboardEmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: AppPadding.a24,
        child: Text(
          'Import your projects from Gitlab or Github using the project selection on the topbar. If you are a member, ask your manager to add you to any project to start.',
          style: AppTextStyle.f24B,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
