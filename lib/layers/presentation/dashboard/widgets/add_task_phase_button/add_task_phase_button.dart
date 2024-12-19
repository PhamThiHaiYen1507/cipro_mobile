import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/dashboard/task/task_builder/task_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

import 'add_task_phase_button_controller.dart';

class AddTaskPhaseButton
    extends MobxStatefulWidget<AddTaskPhaseButtonController> {
  final String projectName;

  final String phaseId;

  final VoidCallback? onAddSuccess;

  const AddTaskPhaseButton({
    super.key,
    required this.projectName,
    required this.phaseId,
    this.onAddSuccess,
  });

  @override
  _AddTaskPhaseButtonState createState() => _AddTaskPhaseButtonState();
}

class _AddTaskPhaseButtonState
    extends MobxState<AddTaskPhaseButton, AddTaskPhaseButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: showSelectTask,
      backgroundColor: AppColors.primaryColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white),
          Text('Add tasks'),
        ],
      ),
    );
  }

  void showSelectTask() {
    AppDialog.dialog(
      backgroundColor: Colors.white,
      context: context,
      insetPadding: const EdgeInsets.all(16),
      title: 'Add task to phase',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select row to add task to phase'),
          AppSpacing.h16,
          const Row(
            children: [
              Expanded(
                  child: Text(
                'Name',
                style: AppTextStyle.f14B,
              )),
              Expanded(
                  child: Text(
                'Status',
                style: AppTextStyle.f14B,
              )),
              Expanded(
                flex: 2,
                child: Text(
                  'Description',
                  style: AppTextStyle.f14B,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 320,
            width: double.maxFinite,
            child: TaskBuilder(
              projectName: widget.projectName,
              filter: 'unassigned',
              builder: (tasks) {
                return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return InkWell(
                        onTap: () => addTaskToPhase(task.taskId),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          )),
                          padding: AppPadding.v8,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextMarqueeWidget(
                                child: Text(
                                  task.name ?? '',
                                  style: AppTextStyle.f14R,
                                ),
                              )),
                              Expanded(
                                  child: Text(
                                task.status ?? '',
                                style: AppTextStyle.f14R,
                              )),
                              Expanded(
                                flex: 2,
                                child: TextMarqueeWidget(
                                  child: Text(
                                    task.description ?? '',
                                    style: AppTextStyle.f14R,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Button(
              onPressed: context.pop,
              child: const Text('Close'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addTaskToPhase(String taskId) async {
    context.pop();

    final res = await controller.addTaskToPhase(widget.phaseId, taskId);

    if (res) {
      AppDialog.showNotification(
        context: context,
        message: 'Add task success',
        type: NotificationType.success,
      );
      widget.onAddSuccess?.call();
    } else {
      AppDialog.showNotification(
        context: context,
        message: 'Add task failed',
        type: NotificationType.error,
      );
    }
  }
}
