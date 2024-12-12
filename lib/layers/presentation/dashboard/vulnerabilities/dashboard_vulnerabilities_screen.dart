import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/dashboard/vulnerabilities/vulnerability_progress_builder/vulnerability_progress_builder.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/artifact_builder/artifact_builder.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

class DashboardVulnerabilitiesScreen extends StatelessWidget {
  final String projectName;

  const DashboardVulnerabilitiesScreen({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return ArtifactBuilder(
        projectName: projectName,
        builder: (artifacts) {
          if (artifacts.isEmpty) return const SizedBox();

          return DefaultTabController(
            length: artifacts.length,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppPadding.a16,
                    child: Column(
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
                                        'Total vulnerabilities'.toUpperCase(),
                                        style: AppTextStyle.f16B,
                                      ),
                                    ),
                                    VulnerabilityProgressBuilder(
                                      projectName: projectName,
                                      builder: (total, resolved) => Text(
                                        Utils.formatNumber(total),
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
                                          'Total threats'.toUpperCase(),
                                          style: AppTextStyle.f16B,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      Utils.formatNumber(artifacts.length),
                                      style: AppTextStyle.f32B,
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
                          child: VulnerabilityProgressBuilder(
                              projectName: projectName,
                              builder: (total, resolved) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: TextMarqueeWidget(
                                        child: Text(
                                          'Resolution progress'.toUpperCase(),
                                          style: AppTextStyle.f16B,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      Utils.formatNumber(
                                        total > 0 ? resolved / total : 0,
                                        pattern: NumberPattern.percentInterger,
                                      ),
                                      style: AppTextStyle.f32B,
                                    ),
                                    Container(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.4),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: resolved,
                                              child: Container(
                                                height: 5,
                                                color: AppColors.primaryColor,
                                              )),
                                          Expanded(
                                            flex: total,
                                            child: Container(
                                              height: 5,
                                              color: Colors.transparent,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                        AppSpacing.h16,
                        Container(
                          padding: AppPadding.a16,
                          decoration: context.defaultBox,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Severity statistics',
                                style: AppTextStyle.f16B,
                              ),
                              Builder(
                                builder: (context) {
                                  final counts =
                                      artifacts.fold<Map<String, double>>(
                                    {},
                                    (previousValue, element) {
                                      for (var vuln
                                          in element.vulnerabilityList) {
                                        previousValue[
                                                '${vuln.severity ?? ''} severity'] ??=
                                            0.0;

                                        previousValue[
                                                '${vuln.severity ?? ''} severity'] =
                                            previousValue[
                                                    '${vuln.severity ?? ''} severity']! +
                                                1.0;
                                      }

                                      return previousValue;
                                    },
                                  );

                                  return PieChart(
                                    dataMap: counts,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: 16,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: const [
                                      Colors.grey,
                                      Colors.green,
                                      Colors.orange,
                                      Colors.red,
                                      Colors.brown,
                                      Colors.yellow,
                                    ],
                                    initialAngleInDegree: -90,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 24,
                                    legendOptions: const LegendOptions(
                                      legendPosition: LegendPosition.bottom,
                                      showLegends: true,
                                      legendShape: BoxShape.circle,
                                      showLegendsInRow: true,
                                      legendTextStyle: AppTextStyle.f14M,
                                    ),
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: true,
                                      showChartValuesInPercentage: true,
                                      showChartValuesOutside: true,
                                      decimalPlaces: 0,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        AppSpacing.h16,
                        Container(
                          padding: AppPadding.a16,
                          decoration: context.defaultBox,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Threat statistics',
                                  style: AppTextStyle.f16B,
                                ),
                                Builder(
                                  builder: (context) {
                                    final counts =
                                        artifacts.fold<Map<String, double>>(
                                      {},
                                      (previousValue, element) {
                                        for (var threat in element.threatList) {
                                          previousValue[
                                                  '${threat.status?.value ?? ''} threats'] ??=
                                              0.0;

                                          previousValue[
                                                  '${threat.status?.value ?? ''} threats'] =
                                              previousValue[
                                                      '${threat.status?.value ?? ''} threats']! +
                                                  1.0;
                                        }

                                        return previousValue;
                                      },
                                    );

                                    return PieChart(
                                      dataMap: counts,
                                      animationDuration:
                                          const Duration(milliseconds: 800),
                                      chartLegendSpacing: 16,
                                      chartRadius:
                                          MediaQuery.of(context).size.width /
                                              3.2,
                                      colorList: const [
                                        Colors.red,
                                        Colors.orange,
                                        Colors.green,
                                        Colors.yellow,
                                      ],
                                      initialAngleInDegree: -90,
                                      chartType: ChartType.ring,
                                      ringStrokeWidth: 24,
                                      legendOptions: const LegendOptions(
                                        legendPosition: LegendPosition.bottom,
                                        showLegends: true,
                                        legendShape: BoxShape.circle,
                                        showLegendsInRow: true,
                                        legendTextStyle: AppTextStyle.f14M,
                                      ),
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValueBackground: false,
                                        showChartValues: true,
                                        showChartValuesInPercentage: true,
                                        showChartValuesOutside: true,
                                        decimalPlaces: 0,
                                      ),
                                    );
                                  },
                                )
                              ]),
                        ),
                        AppSpacing.h16,
                      ],
                    ),
                  ),
                ),
              ],
              body: Column(
                children: [
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: artifacts.map((e) => Tab(text: e.name)).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: artifacts
                          .map((e) => DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  const TabBar(
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    tabs: [
                                      Tab(text: 'Vulnerabilities'),
                                      Tab(text: 'Threats'),
                                    ],
                                  ),
                                  Expanded(
                                      child: TabBarView(children: [
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          AppSpacing.h16,
                                      itemCount: e.vulnerabilityList.length,
                                      itemBuilder: (context, index) {
                                        final vuln = e.vulnerabilityList[index];

                                        return Row(
                                          children: [
                                            const Padding(
                                              padding: AppPadding.a16,
                                              child: Icon(Icons.bug_report),
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  vuln.cveId ?? '',
                                                  style: AppTextStyle.f16M,
                                                ),
                                                getText('Description',
                                                    vuln.description ?? ''),
                                                getText(
                                                    'Score',
                                                    Utils.formatNumber(
                                                        vuln.score,
                                                        defaultValue: '')),
                                                getText('Severity',
                                                    vuln.severity ?? ''),
                                                getText('CWEs',
                                                    vuln.cwes.join(', ')),
                                              ],
                                            ))
                                          ],
                                        );
                                      },
                                    ),
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          AppSpacing.h16,
                                      itemCount: e.threatList.length,
                                      itemBuilder: (context, index) {
                                        final threat = e.threatList[index];

                                        return Row(
                                          children: [
                                            const Padding(
                                              padding: AppPadding.a16,
                                              child: Icon(Icons.bug_report),
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  threat.name ?? '',
                                                  style: AppTextStyle.f16M,
                                                ),
                                                getText('Description',
                                                    threat.description ?? ''),
                                                getText(
                                                    'Score',
                                                    Utils.formatNumber(
                                                        threat.score?.total,
                                                        defaultValue: '')),
                                                getText('Status',
                                                    threat.status?.value ?? ''),
                                              ],
                                            ))
                                          ],
                                        );
                                      },
                                    )
                                  ]))
                                ],
                              )))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget getText(String title, String content) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: title, style: AppTextStyle.f14B),
      const TextSpan(text: ': ', style: AppTextStyle.f14B),
      TextSpan(text: content),
    ]));
  }
}
