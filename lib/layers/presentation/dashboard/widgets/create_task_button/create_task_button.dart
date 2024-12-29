import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/widgets/calendar_picker/calendar_picker.dart';
import 'package:base_project/layers/presentation/widgets/project_member_builder/project_member_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/helpers/app_text_style.dart';
import '../../../../domain/entities/project_member_info_model.dart';
import '../../../widgets/custom_dropdown/custom_dropdown.dart';
import 'create_task_button_controller.dart';

class CreateTaskButton extends MobxStatefulWidget<CreateTaskButtonController> {
  final String projectName;

  final String phaseId;

  final VoidCallback? onCreateSuccess;

  const CreateTaskButton({
    super.key,
    required this.projectName,
    this.onCreateSuccess,
    required this.phaseId,
  });

  @override
  _CreateTaskButtonState createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState
    extends MobxState<CreateTaskButton, CreateTaskButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: showCreateTaskForm,
      backgroundColor: Colors.orangeAccent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white),
          Text('Create a new task'),
        ],
      ),
    );
  }

  void showCreateTaskForm() {
    AppDialog.dialog(
      context: context,
      content: CreateTaskForm(
        onCancel: context.pop,
        projectName: widget.projectName,
        onCreate: (name, description, dueDate, assigneeId) async {
          final res = await controller.createNewTask(
            projectName: widget.projectName,
            name: name,
            description: description,
            dueDate: dueDate,
            phaseId: widget.phaseId,
            assigneeId: assigneeId,
          );

          context.pop();

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Create task success',
              type: NotificationType.success,
            );
            widget.onCreateSuccess?.call();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Create task failed',
              type: NotificationType.error,
            );
          }
        },
      ),
      title: 'Create a new task',
    );
  }
}

class CreateTaskForm extends StatefulWidget {
  final VoidCallback onCancel;

  final String projectName;

  final void Function(
          String name, String description, DateTime dueDate, String assigneeId)
      onCreate;

  const CreateTaskForm(
      {super.key,
      required this.onCancel,
      required this.onCreate,
      required this.projectName});

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final TextEditingController name = TextEditingController();

  final TextEditingController description = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDueDate = DateTime.now();

  ProjectMemberInfoModel? selectedAssignee;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextInputValidator(
          controller: name,
          label: 'Name',
          validator: (value) => TextValidate.validateEmpty(value,
              errorText: 'Name cannot be empty'),
        ),
        AppSpacing.h16,
        TextInputValidator(
          controller: description,
          label: 'Description',
          validator: (value) => TextValidate.validateEmpty(value,
              errorText: 'Description cannot be empty'),
        ),
        AppSpacing.h16,
        const TextInputValidator(
          label: 'Status',
          initialText: 'active',
          enabled: false,
        ),
        AppSpacing.h16,
        CalendarPicker(
          initialDate: selectedDueDate,
          onChanged: (date) => selectedDueDate = date,
        ),
        AppSpacing.h16,
        ProjectMemberBuilder(
          projectName: widget.projectName,
          builder: (_, members) => CustomDropdown(
            items: members,
            fitSize: true,
            placeHolderBuilder: () => Padding(
              padding: AppPadding.h8,
              child: Text(
                'Assignee',
                style: AppTextStyle.f16R.copyWith(color: Colors.grey),
              ),
            ),
            itemBuilder: (item) => Container(
              alignment: Alignment.centerLeft,
              padding: AppPadding.a8,
              child: Text(
                item.account?.username ?? '',
              ),
            ),
            selectedItem: selectedAssignee,
            onSelected: (item) => setState(() {
              selectedAssignee = item;
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
                onPressed: () {
                  if (formKey.currentState?.validate() == true &&
                      selectedAssignee != null) {
                    widget.onCreate(name.text, description.text,
                        selectedDueDate, selectedAssignee!.memberId);
                  }
                },
                child: const Text('Create'),
              ),
            ),
          ],
        )
      ]),
    );
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }
}
