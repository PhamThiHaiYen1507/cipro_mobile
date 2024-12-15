import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/widgets/calendar_picker/calendar_picker.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'create_task_button_controller.dart';

class CreateTaskButton extends MobxStatefulWidget<CreateTaskButtonController> {
  final String projectName;

  final VoidCallback? onCreateSuccess;

  const CreateTaskButton({
    super.key,
    required this.projectName,
    this.onCreateSuccess,
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
        onCreate: (name, description, dueDate) async {
          final res = await controller.createNewTask(
            projectName: widget.projectName,
            name: name,
            description: description,
            dueDate: dueDate,
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

  final void Function(String name, String description, DateTime dueDate)
      onCreate;

  const CreateTaskForm(
      {super.key, required this.onCancel, required this.onCreate});

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final TextEditingController name = TextEditingController();

  final TextEditingController description = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDueDate = DateTime.now();

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
        const SizedBox(height: 16),
        TextInputValidator(
          controller: description,
          label: 'Description',
          validator: (value) => TextValidate.validateEmpty(value,
              errorText: 'Description cannot be empty'),
        ),
        const SizedBox(height: 16),
        const TextInputValidator(
          label: 'Status',
          initialText: 'active',
          enabled: false,
        ),
        const SizedBox(height: 16),
        CalendarPicker(
          initialDate: selectedDueDate,
          onChanged: (date) => selectedDueDate = date,
        ),
        Row(
          children: [
            Expanded(
              child: Button(
                backgroundColor: Colors.red,
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Button(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    widget.onCreate(
                        name.text, description.text, selectedDueDate);
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
