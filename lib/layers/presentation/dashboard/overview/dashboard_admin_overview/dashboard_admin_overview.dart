import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/account_list_builder/account_list_builder.dart';
import 'package:base_project/layers/presentation/widgets/phase_template_builder/phase_template_builder.dart';
import 'package:base_project/layers/presentation/widgets/scanner_list_builder/scanner_list_builder.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

import '../../../widgets/activity_history_builder/activity_history_builder.dart';

class DashboardAdminOverview extends StatelessWidget {
  const DashboardAdminOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPadding.a16,
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: AppPadding.a16,
                    decoration: context.defaultBox,
                    child: Column(
                      children: [
                        Text(
                          'Active user'.toUpperCase(),
                          style: AppTextStyle.f16B,
                        ),
                        AccountListBuilder(
                          builder: (accounts) => Text(
                            Utils.formatNumber(accounts.length),
                            style: AppTextStyle.f32B,
                          ),
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
                              'Scanning tool available'.toUpperCase(),
                              style: AppTextStyle.f16B,
                            ),
                          ),
                        ),
                        ScannerListBuilder(
                          builder: (scanners) => Text(
                            Utils.formatNumber(scanners.length),
                            style: AppTextStyle.f32B,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.h16,
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: AppPadding.a16,
                    decoration: context.defaultBox,
                    child: Column(
                      children: [
                        Text(
                          'Default tool'.toUpperCase(),
                          style: AppTextStyle.f16B,
                        ),
                        const Text(
                          'Grype',
                          style: AppTextStyle.f32B,
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
                              'Phase templates available'.toUpperCase(),
                              style: AppTextStyle.f16B,
                            ),
                          ),
                        ),
                        PhaseTemplateBuilder(
                          builder: (_, templates) => Text(
                            Utils.formatNumber(templates.length),
                            style: AppTextStyle.f32B,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.h16,
            Container(
              padding: AppPadding.a16,
              decoration: context.defaultBox,
              child: Column(
                children: [
                  Text(
                    'Role distribution'.toUpperCase(),
                    style: AppTextStyle.f16B,
                  ),
                  AppSpacing.h16,
                  AccountListBuilder(
                    builder: (accounts) {
                      final adminRoles = accounts
                          .where((element) => element.role == AccountRole.admin)
                          .toList();
                      final managerRoles = accounts
                          .where(
                              (element) => element.role == AccountRole.manager)
                          .toList();
                      final memberRoles = accounts
                          .where(
                              (element) => element.role == AccountRole.member)
                          .toList();
                      final colorList = <Color>[
                        Colors.red,
                        Colors.yellow,
                        Colors.green
                      ];

                      return PieChart(
                        dataMap: {
                          'Admin':
                              (adminRoles.isNotEmpty ? adminRoles.length : 0)
                                  .toDouble(),
                          'Manager': (managerRoles.isNotEmpty
                                  ? managerRoles.length
                                  : 0)
                              .toDouble(),
                          'Member':
                              (memberRoles.isNotEmpty ? memberRoles.length : 0)
                                  .toDouble()
                        },
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 32,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            AppSpacing.h16,
            Container(
              width: double.maxFinite,
              padding: AppPadding.a16,
              decoration: context.defaultBox,
              child: Column(
                children: [
                  Text(
                    'Recent activity'.toUpperCase(),
                    style: AppTextStyle.f16B,
                  ),
                  AppSpacing.h16,
                  ActivityHistoryBuilder(
                    builder: (histories) {
                      return Column(
                        children: histories.reversed
                            .map((e) => Padding(
                                  padding: AppPadding.a8,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                            Utils.getTimeDifferenceFromNow(
                                                e.timestamp ?? DateTime.now())),
                                      ),
                                      IntrinsicHeight(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 12,
                                              height: 12,
                                              margin: AppPadding.a4,
                                              decoration: const BoxDecoration(
                                                color: AppColors.primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Text(e.description ?? '')),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
