import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/project_info/project_info.dart';
import 'package:base_project/layers/presentation/widgets/project_activity_builder/project_activity_builder.dart';
import 'package:base_project/layers/presentation/widgets/project_member_info_builder/project_member_info_builder.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';

class DashboardMemberOverview extends StatelessWidget {
  final String projectName;

  const DashboardMemberOverview({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    final AccountManagerController accountManager = MobxManager.get();

    return ListView(
      padding: AppPadding.a16,
      children: [
        Container(
          padding: AppPadding.a16,
          decoration: context.defaultBox,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent activity'.toUpperCase(),
                style: AppTextStyle.f16B,
              ),
              AppSpacing.h16,
              ProjectActivityBuilder(
                projectName: projectName,
                username: accountManager.accountInfo?.username,
                builder: (activities) {
                  return Column(
                    children: activities
                        .map((e) => Padding(
                              padding: AppPadding.v8,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.merge,
                                    size: 32,
                                  ),
                                  AppSpacing.a16,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.content ?? ''),
                                        Text(
                                          'Created: ${Utils.formatDateToDisplay(e.createdAt)}',
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
        AppSpacing.h16,
        ProjectInfo(projectName: projectName),
        AppSpacing.h16,
        Container(
          padding: AppPadding.a16,
          decoration: context.defaultBox,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Assigned',
                style: AppTextStyle.f16B,
              ),
              AppSpacing.h16,
              ProjectMemberInfoBuilder(
                accountId: accountManager.accountInfo?.accountId ?? '',
                builder: (member) {
                  return Column(
                    children: member?.taskAssigned.map(
                          (e) {
                            return Padding(
                              padding: AppPadding.v8,
                              child: Row(
                                children: [
                                  const Icon(Icons.event_note_rounded),
                                  AppSpacing.w16,
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name ?? '',
                                        style: AppTextStyle.f16M,
                                      ),
                                      Text(e.description ?? '')
                                    ],
                                  ))
                                ],
                              ),
                            );
                          },
                        ).toList() ??
                        [],
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
