import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/widgets/custom_tooltip/custom_tooltip.dart';
import 'package:base_project/layers/presentation/widgets/project_builder/project_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

import 'dashboard_script_controller.dart';
import 'guide/guide.dart';

class DashboardScriptScreen
    extends MobxStatefulWidget<DashboardScriptController> {
  final String projectName;

  const DashboardScriptScreen({super.key, required this.projectName});

  @override
  _DashboardScriptScreenState createState() => _DashboardScriptScreenState();
}

class _DashboardScriptScreenState
    extends MobxState<DashboardScriptScreen, DashboardScriptController> {
  final CustomToolTipController toolTipController = CustomToolTipController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: AppPadding.h16,
            child: CustomToolTip(
              barrierDismissible: true,
              controller: toolTipController,
              tooltip: Container(
                decoration: context.defaultBox,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.sonar.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('Sonar Cloud Integration Guide'),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.trivy.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('Trivy Integration Guide'),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.owasp.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('OWASP Integration Guide'),
                      ),
                    ),
                  ],
                ),
              ),
              direction: TooltipDirection.bottom,
              tooltipBottomStart: TooltipBottomStart.right,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child:
                        Text('Workflow in project', style: AppTextStyle.f18B),
                  ),
                  IconButton(
                    onPressed: toolTipController.toggle,
                    icon: const Icon(Icons.settings_suggest_sharp),
                  ),
                  ProjectBuilder(
                      projectName: widget.projectName,
                      builder: (c, _) {
                        return IconButton(
                          onPressed: () => controller
                              .syncWorkflowInfo(widget.projectName)
                              .then((value) async {
                            c.getProjectInfo();
                          }),
                          icon: const Icon(Icons.refresh_rounded),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ProjectBuilder(
            projectName: widget.projectName,
            builder: (_, project) {
              if (project == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: AppPadding.a8.add(AppPadding.h8),
                      decoration: context.defaultBox,
                      padding: AppPadding.a16,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total workflow runs',
                                style: AppTextStyle.f16B,
                              ),
                              Text(
                                Utils.formatNumber(project.workflows.fold<num>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.totalRuns,
                                )),
                                style: AppTextStyle.f16B,
                              ),
                            ],
                          ),
                          AppSpacing.h16,
                          Builder(
                            builder: (context) {
                              final counts =
                                  project.workflows.fold<Map<String, double>>(
                                {},
                                (previousValue, element) {
                                  final key = element.name;

                                  previousValue[key] ??=
                                      element.totalRuns.toDouble();

                                  return previousValue;
                                },
                              );

                              if (counts.isEmpty) return const SizedBox();

                              return PieChart(
                                dataMap: counts,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                chartLegendSpacing: 16,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                colorList: const [
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
                                chartValuesOptions: const ChartValuesOptions(
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
                  ),
                  SliverPadding(
                    padding: AppPadding.a8,
                    sliver: SliverList.builder(
                      itemCount: project.workflows.length,
                      itemBuilder: (context, index) {
                        final workflow = project.workflows[index];

                        return GestureDetector(
                          onTap: () =>
                              goToDetail(widget.projectName, workflow.id!),
                          child: Container(
                            margin: AppPadding.a8,
                            padding: AppPadding.a16,
                            decoration: context.defaultBox,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextMarqueeWidget(
                                      child: Text(
                                        workflow.name,
                                        style: AppTextStyle.f16B,
                                      ),
                                    )),
                                    // Switch(
                                    //   value: workflow.state == 'active',
                                    //   onChanged: (value) {
                                    //     workflow.state =
                                    //         value ? 'active' : 'inactive';

                                    //     setState(() {});

                                    //     if (workflow.id != null) {
                                    //       controller.onChangedStatus(
                                    //           widget.projectName,
                                    //           workflow.id!,
                                    //           value);
                                    //     }
                                    //   },
                                    // )
                                  ],
                                ),
                                AppSpacing.h16,
                                _buildWorkflowInfo(
                                    'Name', Icons.abc, workflow.name),
                                _buildWorkflowInfo(
                                    'Path', Icons.link, workflow.path),
                                _buildWorkflowInfo(
                                  'Status',
                                  Icons.online_prediction_outlined,
                                  workflow.state ?? 'active',
                                ),
                                _buildWorkflowInfo(
                                  'Created at',
                                  Icons.date_range,
                                  Utils.formatDateToDisplay(
                                      workflow.createdAt ?? DateTime.now()),
                                ),
                                _buildWorkflowInfo(
                                    'Workflow runs',
                                    Icons.history,
                                    Utils.formatNumber(workflow.totalRuns)),
                                _buildWorkflowInfo('URL', Icons.link_outlined,
                                    workflow.url ?? '-'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Expanded(
        //   child: ProjectWorkflowListBuilder(
        //       projectName: widget.projectName,
        //       builder: (workflows) {
        //         if (workflows.isEmpty) {
        //           return const Center(
        //               child: Text('Found no workflow in this project.'));
        //         }

        //         return ListView.separated(
        //           padding: AppPadding.a16,
        //           separatorBuilder: (context, index) => AppSpacing.h16,
        //           itemCount: workflows.length,
        //           itemBuilder: (context, i) {
        //             final workflow = workflows[i];

        //             return Container(
        //               padding: AppPadding.a16,
        //               decoration: context.defaultBox,
        //               child: Text(workflow.content),
        //             );
        //           },
        //         );
        //       }),
        // ),
      ],
    );
  }

  void goToDetail(String projectName, String workflowId) {
    ScriptDetailScreenRoute(projectName: projectName, workflowId: workflowId)
        .push(context);
  }

  Widget _buildWorkflowInfo(String title, IconData icon, String value) {
    return Padding(
      padding: AppPadding.v8,
      child: Row(
        children: [
          Icon(icon),
          AppSpacing.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.f16M,
                ),
                TextMarqueeWidget(child: Text(value))
              ],
            ),
          )
        ],
      ),
    );
  }
}
