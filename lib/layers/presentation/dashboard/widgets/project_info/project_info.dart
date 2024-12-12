import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/project_builder/project_builder.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

class ProjectInfo extends StatelessWidget {
  final String projectName;

  const ProjectInfo({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return ProjectBuilder(
        projectName: projectName,
        builder: (project) {
          return Container(
            width: double.maxFinite,
            padding: AppPadding.a16,
            decoration: context.defaultBox,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project details',
                  style: AppTextStyle.f24B,
                ),
                AppSpacing.h24,
                Padding(
                  padding: AppPadding.v8,
                  child: Row(
                    children: [
                      const Icon(Icons.abc),
                      AppSpacing.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Project name',
                              style: AppTextStyle.f16M,
                            ),
                            TextMarqueeWidget(child: Text(project?.name ?? ''))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: AppPadding.v8,
                  child: Row(
                    children: [
                      const Icon(Icons.link),
                      AppSpacing.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'URL',
                              style: AppTextStyle.f16M,
                            ),
                            TextMarqueeWidget(
                              child: Text(
                                project?.url ?? '',
                                style: AppTextStyle.f14R.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: AppPadding.v8,
                  child: Row(
                    children: [
                      const Icon(Icons.power_settings_new_rounded),
                      AppSpacing.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: AppTextStyle.f16M,
                            ),
                            TextMarqueeWidget(
                                child: Text(project?.status ?? ''))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: AppPadding.v8,
                  child: Row(
                    children: [
                      const Icon(Icons.access_time),
                      AppSpacing.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create at',
                              style: AppTextStyle.f16M,
                            ),
                            TextMarqueeWidget(
                              child: Text(
                                Utils.formatDateToDisplay(project?.createdAt),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: AppPadding.v8,
                  child: Row(
                    children: [
                      const Icon(Icons.access_time),
                      AppSpacing.w16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last updated at',
                              style: AppTextStyle.f16M,
                            ),
                            TextMarqueeWidget(
                              child: Text(
                                Utils.formatDateToDisplay(project?.updatedAt),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
