import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/project_info/project_info.dart';
import 'package:base_project/layers/presentation/widgets/project_activity_builder/project_activity_builder.dart';
import 'package:base_project/layers/presentation/widgets/project_member_builder/project_member_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

class DashboardProjectHomeScreen extends StatefulWidget {
  final AccountRole role;

  final String projectName;

  const DashboardProjectHomeScreen(
      {super.key, required this.projectName, required this.role});

  @override
  State<DashboardProjectHomeScreen> createState() =>
      _DashboardProjectHomeScreenState();
}

class _DashboardProjectHomeScreenState
    extends State<DashboardProjectHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ListView(
        padding: AppPadding.a16,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: AppPadding.a16,
                  decoration: context.defaultBox,
                  child: Column(
                    children: [
                      TextMarqueeWidget(
                        child: Text(
                          'Total commits'.toUpperCase(),
                          style: AppTextStyle.f16B,
                        ),
                      ),
                      ProjectActivityBuilder(
                        projectName: widget.projectName,
                        builder: (activities) {
                          final commits = activities
                              .where((element) => element.action == 'commit')
                              .toList();
                          return Text(
                            Utils.formatNumber(commits.length),
                            style: AppTextStyle.f32B,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              AppSpacing.a16,
              Expanded(
                child: Container(
                  padding: AppPadding.a16,
                  decoration: context.defaultBox,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: TextMarqueeWidget(
                          child: Text(
                            'Total pull requests'.toUpperCase(),
                            style: AppTextStyle.f16B,
                          ),
                        ),
                      ),
                      ProjectActivityBuilder(
                        projectName: widget.projectName,
                        builder: (activities) {
                          final pullRequests = activities
                              .where((element) => element.action == 'pr')
                              .toList();
                          return Text(
                            Utils.formatNumber(pullRequests.length),
                            style: AppTextStyle.f32B,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.h16,
          ProjectMemberBuilder(
              projectName: widget.projectName,
              builder: (members) {
                return Container(
                  width: double.maxFinite,
                  padding: AppPadding.a16,
                  decoration: context.defaultBox,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Members',
                          style: AppTextStyle.f24B,
                        ),
                        AppSpacing.h16,
                        Column(
                          children: members
                              .map(
                                (e) => InkWell(
                                  onTap: () => MemberInfoScreenRoute(e.memberId)
                                      .push(context),
                                  child: Padding(
                                    padding: AppPadding.v8,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.account_circle),
                                        AppSpacing.a8,
                                        TextMarqueeWidget(
                                          child: Text(
                                            '${e.account?.username} (${e.name})',
                                            style: AppTextStyle.f16M.copyWith(
                                                color: AppColors.primaryColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ]),
                );
              }),
          AppSpacing.h16,
          ProjectInfo(projectName: widget.projectName),
          AppSpacing.h16,
          ProjectActivityBuilder(
              projectName: widget.projectName,
              builder: (activities) {
                final Map<String?, List<ProjectActivityInfoModel>> data = {};

                for (var activity in activities) {
                  final list = data[activity.createdBy] ?? [];

                  list.add(activity);

                  data[activity.createdBy] = list;
                }

                return Container(
                  width: double.maxFinite,
                  padding: AppPadding.a16,
                  decoration: context.defaultBox,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Activity history',
                        style: AppTextStyle.f24B,
                      ),
                      AppSpacing.h16,
                      SizedBox(
                        height: 250,
                        child: BarChart(BarChartData(
                            borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                )),
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) => SizedBox(
                                    width: 55,
                                    child: Center(
                                      child: TextMarqueeWidget(
                                        child: Text(data.entries
                                                .toList()[value.toInt()]
                                                .key ??
                                            ''),
                                      ),
                                    ),
                                  ),
                                )),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: false,
                                ))),
                            barGroups: data.entries.mapIndexed((i, e) {
                              return BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: e.value
                                        .where(
                                            (element) => element.action == 'pr')
                                        .length
                                        .toDouble(),
                                    color:
                                        AppColors.primaryColor.withOpacity(0.4),
                                  ),
                                  BarChartRodData(
                                    toY: e.value
                                        .where((element) =>
                                            element.action == 'commit')
                                        .length
                                        .toDouble(),
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              );
                            }).toList(),
                            barTouchData: BarTouchData())),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
