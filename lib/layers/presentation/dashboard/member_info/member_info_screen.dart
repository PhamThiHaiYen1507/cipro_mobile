import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/assign_task_button/assign_task_button.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/delete_member_project_button/delete_member_project_button.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/layers/presentation/widgets/project_member_info_builder/project_member_info_builder.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../../core/state_manager/mobx_manager.dart';
import 'member_info_controller.dart';

class MemberInfoScreen extends MobxStatefulWidget<MemberInfoController> {
  final String projectName;

  final String memberId;

  const MemberInfoScreen(
      {super.key, required this.memberId, required this.projectName});

  @override
  _MemberInfoScreenState createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState
    extends MobxState<MemberInfoScreen, MemberInfoController> {
  @override
  Widget build(BuildContext context) {
    return ProjectMemberInfoBuilder(
      memberId: widget.memberId,
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

        return Scaffold(
          appBar: AppBar(),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: AppPadding.h16,
                        padding: AppPadding.a16,
                        decoration: context.defaultBox,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.account_circle_rounded,
                                  size: 120,
                                  color: Colors.blueGrey,
                                ),
                                Row(
                                  children: [
                                    AppSpacing.a8,
                                    Expanded(
                                      child: member?.name?.isNotEmpty == true
                                          ? TextMarqueeWidget(
                                              child: Text(
                                                member?.name ?? '',
                                                style: AppTextStyle.f24B,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                    AppSpacing.a8,
                                    Container(
                                      padding: AppPadding.a8.add(AppPadding.h8),
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: AppBorderRadius.xl,
                                      ),
                                      child: Text(
                                        member?.account?.role.name ?? '',
                                        style: AppTextStyle.f16B
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: DeleteMemberProjectButton(
                                projectName: widget.projectName,
                                accountId: member?.account?.accountId ?? '',
                                onRemoveSuccess: context.pop,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
              body: Column(
                children: [
                  AppSpacing.h16,
                  Container(
                    padding: AppPadding.h16,
                    alignment: Alignment.centerRight,
                    child: AssignTaskButton(
                      projectName: widget.projectName,
                      onSuccess: c.getProjectMemberFromId,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: AppPadding.a16,
                      decoration: context.defaultBox,
                      child: GridTable<TaskInfoModel>(
                        items: member?.taskAssigned
                                .where((element) =>
                                    element.projectName == widget.projectName)
                                .toList() ??
                            [],
                        configs: configs,
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
