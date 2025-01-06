import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/dashboard/task/task_builder/task_builder.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/layers/presentation/widgets/project_member_builder/project_member_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/helpers/app_padding.dart';
import '../../../../domain/entities/project_member_info_model.dart';
import '../../../../domain/entities/task_info_model.dart';
import '../../../common/button/button.dart';
import 'assign_task_button_controller.dart';

class AssignTaskButton extends MobxStatefulWidget<AssignTaskButtonController> {
  final String projectName;

  final void Function() onSuccess;

  const AssignTaskButton(
      {super.key, required this.projectName, required this.onSuccess});

  @override
  _AssignTaskButtonState createState() => _AssignTaskButtonState();
}

class _AssignTaskButtonState
    extends MobxState<AssignTaskButton, AssignTaskButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: showAssignTaskDialog,
      child: const Text('Assign tasks'),
    );
  }

  void showAssignTaskDialog() {
    AppDialog.dialog(
      context: context,
      title: 'Assign tasks',
      insetPadding: AppPadding.a16,
      content: AssignTaskForm(
        projectName: widget.projectName,
        onCancel: context.pop,
        onSubmit: (memberId, taskId) async {
          final res = await controller.assignTask(memberId, taskId);

          context.pop();

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Assign task success',
              type: NotificationType.success,
            );
            widget.onSuccess();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Assign task failed',
              type: NotificationType.error,
            );
          }
        },
      ),
    );
  }
}

class AssignTaskForm extends StatefulWidget {
  final String projectName;

  final VoidCallback onCancel;

  final void Function(String memberId, String taskId) onSubmit;

  const AssignTaskForm(
      {super.key,
      required this.projectName,
      required this.onCancel,
      required this.onSubmit});

  @override
  State<AssignTaskForm> createState() => _AssignTaskFormState();
}

class _AssignTaskFormState extends State<AssignTaskForm> {
  ProjectMemberInfoModel? selectedUser;

  TaskInfoModel? selectedTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TaskBuilder(
          projectName: widget.projectName,
          builder: (tasks) {
            return CustomDropdown(
              items: tasks,
              fitSize: true,
              constraints: const BoxConstraints(maxHeight: 250),
              placeHolderBuilder: () => Padding(
                padding: AppPadding.h8,
                child: Text(
                  'Task',
                  style: AppTextStyle.f14R.copyWith(color: Colors.grey),
                ),
              ),
              selectedBuilder: (item) => Padding(
                padding: AppPadding.h8,
                child: Text(
                  item.name ?? '',
                  style: AppTextStyle.f14B,
                ),
              ),
              itemBuilder: (item) => Container(
                alignment: Alignment.centerLeft,
                padding: AppPadding.a8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name ?? '', style: AppTextStyle.f16M),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Description: ',
                        style: AppTextStyle.f14B,
                      ),
                      TextSpan(text: item.description ?? '')
                    ])),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                        text: 'Due date: ',
                        style: AppTextStyle.f14B,
                      ),
                      TextSpan(
                        text: Utils.formatDateToDisplay(item.dueDate),
                      )
                    ]))
                  ],
                ),
              ),
              selectedItem: selectedTask,
              onSelected: (item) => setState(() {
                selectedTask = item;
              }),
            );
          },
        ),
        AppSpacing.a16,
        ProjectMemberBuilder(
          projectName: widget.projectName,
          builder: (_, members) => CustomDropdown(
            items: members,
            fitSize: true,
            placeHolderBuilder: () => Padding(
              padding: AppPadding.h8,
              child: Text(
                'Member',
                style: AppTextStyle.f14R.copyWith(color: Colors.grey),
              ),
            ),
            itemBuilder: (item) => Container(
              alignment: Alignment.centerLeft,
              padding: AppPadding.a8,
              child: Text(
                item.account?.username ?? '',
              ),
            ),
            selectedItem: selectedUser,
            onSelected: (item) => setState(() {
              selectedUser = item;
            }),
          ),
        ),
        AppSpacing.h16,
        Row(
          children: [
            Expanded(
              child: Button(
                backgroundColor: Colors.red,
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
            ),
            AppSpacing.w16,
            Expanded(
              child: Button(
                disabled: selectedTask == null || selectedUser == null,
                onPressed: () {
                  widget.onSubmit(
                    selectedUser?.memberId ?? '',
                    selectedTask?.taskId ?? '',
                  );
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
