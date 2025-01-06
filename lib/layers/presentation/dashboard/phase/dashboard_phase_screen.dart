import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_phase_template_button/create_phase_template_button.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/layers/presentation/widgets/project_builder/project_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../widgets/phase_template_builder/phase_template_builder.dart';

class DashboardPhaseScreen extends StatelessWidget {
  final String? projectName;

  const DashboardPhaseScreen({super.key, this.projectName});

  @override
  Widget build(BuildContext context) {
    return ProjectBuilder(
      projectName: projectName,
      builder: (c, project) {
        if (project == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<GridTableColumnConfig<PhaseModel>> configs = [
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Name'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) =>
                Center(child: Text(data.name ?? '')),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Description'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) =>
                Center(child: Text(data.description ?? '')),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Task'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) =>
                Center(child: Text(Utils.formatNumber(data.tasks.length))),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Artifact'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) =>
                Center(child: Text(Utils.formatNumber(data.artifacts.length))),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Detail'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) => IconButton(
              onPressed: () => PhaseDetailScreenRoute(
                      phaseId: data.id, projectName: projectName ?? '')
                  .push(context)
                  .then((value) => c.getProjectInfo()),
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ),
        ];

        if (project.phaseList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      showSelectPhaseTemplateDialog(context, c.getProjectInfo),
                  child: Padding(
                    padding: AppPadding.a8,
                    child: Text(
                      'Select a phase template',
                      style: AppTextStyle.f16B
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                CreatePhaseTemplateButton(
                  projectName: projectName,
                  child: Padding(
                    padding: AppPadding.a8,
                    child: Text(
                      'Create a phase template',
                      style: AppTextStyle.f16B
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                  onCreateSuccess: () => c.getProjectInfo(),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Container(
              margin: AppPadding.a8.add(AppPadding.h8),
              decoration: context.defaultBox,
              height: 44 + project.phaseList.length * 44,
              child: GridTable<PhaseModel>(
                  items: project.phaseList, configs: configs),
            ),
            Container(
              decoration: context.defaultBox,
              padding: AppPadding.a16,
              margin: AppPadding.a8.add(AppPadding.h8),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Task',
                      style: AppTextStyle.f24B,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final completedTasks = project.phaseList.fold(
                          [],
                          (previousValue, element) => previousValue
                            ..addAll(element.tasks.where((element) =>
                                element.status == 'completed'))).toList();
                      final activeTasks = project.phaseList.fold(
                          [],
                          (previousValue, element) => previousValue
                            ..addAll(element.tasks.where((element) =>
                                element.status == 'active'))).toList();

                      return PieChart(
                        dataMap: {
                          'Active': activeTasks.length.toDouble(),
                          'Completed': completedTasks.length.toDouble(),
                        },
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 16,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: const [Colors.purple, Colors.green],
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
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: true,
                          decimalPlaces: 0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: context.defaultBox,
              padding: AppPadding.a16.copyWith(bottom: 32),
              margin: AppPadding.a8.add(AppPadding.h8),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Progress',
                      style: AppTextStyle.f24B,
                    ),
                  ),
                  ...project.phaseList.map(
                    (e) {
                      if (e.tasks.isEmpty) return const SizedBox();

                      final totalCompletedTasks = e.tasks
                          .where((element) => element.status == 'completed')
                          .length;

                      return Row(
                        children: [
                          Text(e.name ?? ''),
                          AppSpacing.w16,
                          Expanded(
                              flex: totalCompletedTasks,
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 38,
                                    color: Colors.green,
                                  ),
                                  Positioned(
                                    bottom: -24,
                                    child: Text(
                                      Utils.formatNumber(
                                        totalCompletedTasks / e.tasks.length,
                                        pattern: NumberPattern.percentInterger,
                                      ),
                                      style: AppTextStyle.f14R.copyWith(
                                        color: Colors.green,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: e.tasks
                                  .where((element) =>
                                      element.status != 'completed')
                                  .length,
                              child: Container(
                                height: 38,
                                color: Colors.transparent,
                              )),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void showSelectPhaseTemplateDialog(
      BuildContext context, void Function() onCreateSuccess) {
    AppDialog.dialog(
      context: context,
      title: 'Select a template',
      insetPadding: AppPadding.a16,
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: PhaseTemplateBuilder(
              builder: (controller, templates) {
                return SingleChildScrollView(
                  child: Column(
                    children: templates
                        .map(
                          (e) => CreatePhaseTemplateButton(
                            projectName: projectName,
                            template: e,
                            onCreateSuccess: () {
                              context.pop();

                              onCreateSuccess();
                            },
                            child: Padding(
                              padding: AppPadding.a8,
                              child: Row(
                                children: [
                                  const Icon(Icons.library_books_outlined),
                                  AppSpacing.w16,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.name,
                                          style: AppTextStyle.f14B.copyWith(
                                              color: AppColors.primaryColor),
                                        ),
                                        Text(e.description)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
