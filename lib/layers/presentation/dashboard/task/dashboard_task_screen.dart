import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/layers/presentation/widgets/project_member_info_builder/project_member_info_builder.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'dashboard_task_controller.dart';

class DashboardTaskScreen extends MobxStatefulWidget<DashboardTaskController> {
  const DashboardTaskScreen({super.key});

  @override
  _DashboardTaskScreenState createState() => _DashboardTaskScreenState();
}

class _DashboardTaskScreenState
    extends MobxState<DashboardTaskScreen, DashboardTaskController> {
  @override
  Widget build(BuildContext context) {
    final AccountManagerController accountManager = MobxManager.get();

    return ProjectMemberInfoBuilder(
      accountId: accountManager.accountInfo?.accountId,
      builder: (c, member) {
        final List<GridTableColumnConfig<TaskInfoModel>> configs = [
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
                child: Text('Status'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) =>
                Center(child: Text(data.status ?? '')),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(220)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.centerLeft,
                child: Text('Description'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) => Align(
                alignment: Alignment.centerLeft,
                child: TextMarqueeWidget(child: Text(data.description ?? ''))),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.centerLeft,
                child: Text('Due date'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Utils.formatDateToDisplay(data.dueDate),
              ),
            ),
          ),
          GridTableColumnConfig(
            columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
            headerBuilder: (context) {
              return Container(
                color: AppColors.greyColor.o(0.2),
                alignment: Alignment.center,
                child: Text('Action'.toUpperCase()),
              );
            },
            cellBuilder: (context, data, index) => Center(
              child: Checkbox(
                value: data.status == 'completed',
                onChanged: (value) async {
                  await controller.updateStatus(
                    data.taskId,
                    !value!,
                  );

                  c.getProjectMemberFromId();
                },
              ),
            ),
          ),
        ];

        return NestedScrollView(
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
                                Text(
                                  'Overdue tasks'.toUpperCase(),
                                  style: AppTextStyle.f16B,
                                ),
                                Text(
                                  Utils.formatNumber(member?.taskAssigned
                                      .where((element) =>
                                          element.createdAt == null
                                              ? false
                                              : element.dueDate!
                                                      .millisecondsSinceEpoch <
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch)
                                      .length),
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
                                      'Completion progress'.toUpperCase(),
                                      style: AppTextStyle.f16B,
                                    ),
                                  ),
                                ),
                                Text(
                                  Utils.formatNumber(
                                    0,
                                    pattern: NumberPattern.percentInterger,
                                  ),
                                  style: AppTextStyle.f32B,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
          body: Container(
            margin: AppPadding.a16,
            decoration: context.defaultBox,
            child: GridTable<TaskInfoModel>(
              items: member?.taskAssigned ?? [],
              configs: configs,
            ),
          ),
        );
      },
    );
  }
}
