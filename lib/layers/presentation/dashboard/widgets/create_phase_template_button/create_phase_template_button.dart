import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/domain/entities/phase_model.dart';
import 'package:base_project/layers/domain/entities/phase_template_model.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/state_manager/mobx_manager.dart';
import '../../../../../utils/app_dialog/app_dialog.dart';
import '../../../../../utils/helpers/text_input_validator.dart';
import '../../../common/text_input_validator/text_input_validator.dart';
import 'create_phase_template_button_controller.dart';

class CreatePhaseTemplateButton
    extends MobxStatefulWidget<CreatePhaseTemplateButtonController> {
  final Widget child;

  final VoidCallback? onCreateSuccess;

  final PhaseTemplateModel? template;

  final String? projectName;

  const CreatePhaseTemplateButton({
    super.key,
    required this.child,
    this.onCreateSuccess,
    this.template,
    this.projectName,
  });

  @override
  _CreatePhaseTemplateButtonState createState() =>
      _CreatePhaseTemplateButtonState();
}

class _CreatePhaseTemplateButtonState extends MobxState<
    CreatePhaseTemplateButton, CreatePhaseTemplateButtonController> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showCreateTemplateForm,
      child: widget.child,
    );
  }

  void showCreateTemplateForm() {
    bool isUpdate = widget.template != null;

    AppDialog.dialog(
      context: context,
      insetPadding: AppPadding.a16.copyWith(bottom: 36, top: 36),
      content: CreateTemplateForm(
        template: widget.template,
        projectName: widget.projectName,
        onCancel: context.pop,
        onCreate: (name, description, isPrivate, phases) async {
          if (widget.projectName != null) {
            onCreatePhaseFromTemplate(
                widget.projectName!, name, description, isPrivate, phases);
          } else {
            createOrUpdateTemplate(name, description, isPrivate, phases);
          }
        },
      ),
      title: widget.projectName != null
          ? 'Submit'
          : '${isUpdate ? 'Update' : 'Create'} a template\'s',
    );
  }

  Future<void> onCreatePhaseFromTemplate(String projectName, String name,
      String description, bool isPrivate, List<PhaseModel> phases) async {
    final result = await controller.onCreateNewPhaseFromTemplate(
      projectName: projectName,
      name: name,
      description: description,
      isPrivate: isPrivate,
      phases: phases,
      templateId: widget.template?.id,
    );

    context.pop();

    if (result) {
      AppDialog.showNotification(
        context: context,
        message: 'Create phase success',
        type: NotificationType.success,
      );
      widget.onCreateSuccess?.call();
    } else {
      AppDialog.showNotification(
        context: context,
        message: 'create phase failed',
        type: NotificationType.error,
      );
    }
  }

  Future<void> createOrUpdateTemplate(String name, String description,
      bool isPrivate, List<PhaseModel> phases) async {
    bool result = false;
    bool isUpdate = widget.template != null;

    if (isUpdate) {
      result = await controller.onUpdatePhaseTemplate(
        templateId: widget.template!.id,
        name: name,
        description: description,
        isPrivate: isPrivate,
        phases: phases,
      );
    } else {
      result = await controller.onCreateNewPhaseTemplate(
        name: name,
        description: description,
        isPrivate: isPrivate,
        phases: phases,
      );
    }

    context.pop();

    if (result) {
      AppDialog.showNotification(
        context: context,
        message: '${isUpdate ? 'Update' : 'Create'} phase template success',
        type: NotificationType.success,
      );
      widget.onCreateSuccess?.call();
    } else {
      AppDialog.showNotification(
        context: context,
        message: '${isUpdate ? 'Update' : 'Create'} phase template failed',
        type: NotificationType.error,
      );
    }
  }
}

class CreateTemplateForm extends StatefulWidget {
  final VoidCallback onCancel;

  final PhaseTemplateModel? template;

  final String? projectName;

  final void Function(String name, String description, bool isPrivate,
      List<PhaseModel> phases) onCreate;

  const CreateTemplateForm(
      {super.key,
      required this.onCancel,
      required this.onCreate,
      this.projectName,
      this.template});

  @override
  State<CreateTemplateForm> createState() => _CreateTemplateFormState();
}

class _CreateTemplateFormState extends State<CreateTemplateForm> {
  late final TextEditingController name =
      TextEditingController(text: widget.template?.name);

  late final TextEditingController description =
      TextEditingController(text: widget.template?.description);

  late final List<PhaseModel> phases = [
    if (widget.template != null) ...widget.template!.phases
  ];

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool isPrivate = widget.template?.isPrivate ?? false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (widget.template == null)
              CheckboxListTile(
                value: isPrivate,
                onChanged: (value) => setState(() {
                  isPrivate = value ?? false;
                }),
                title: const Text('Make this template private'),
              ),
            TextInputValidator(
              controller: name,
              label: 'Template\'s name',
              validator: (value) => TextValidate.validateEmpty(value,
                  errorText: 'Template\'s name cannot be empty'),
            ),
            AppSpacing.h16,
            TextInputValidator(
              controller: description,
              label: 'Description',
              validator: (value) => TextValidate.validateEmpty(value,
                  errorText: 'Description cannot be empty'),
            ),
            AppSpacing.h16,
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: Column(
                children: phases
                    .mapIndexed((i, e) => CreatePhaseForm(
                          key: ValueKey(e.id),
                          index: i,
                          phase: e,
                          onRemoved: () => onRemovedPhase(e),
                        ))
                    .toList(),
              ),
            ),
            AppSpacing.h16,
            Button(
              width: double.maxFinite,
              onPressed: onAddNewPhase,
              child: const Text('Add phase'),
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
                      if (formKey.currentState?.validate() == true) {
                        widget.onCreate(
                            name.text, description.text, isPrivate, phases);
                      }
                    },
                    child: Text(widget.projectName != null
                        ? 'Create'
                        : widget.template != null
                            ? 'Update'
                            : 'Create'),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void onAddNewPhase() {
    setState(() {
      phases.add(
        PhaseModel(
          order: phases.length,
          id: Utils.generateId,
          tasks: [],
          artifacts: [],
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  void onRemovedPhase(PhaseModel item) {
    setState(() {
      phases.remove(item);
    });
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }
}

class CreatePhaseForm extends StatefulWidget {
  final int index;

  final PhaseModel phase;

  final void Function() onRemoved;

  const CreatePhaseForm(
      {super.key,
      required this.phase,
      required this.index,
      required this.onRemoved});

  @override
  State<CreatePhaseForm> createState() => _CreatePhaseFormState();
}

class _CreatePhaseFormState extends State<CreatePhaseForm> {
  late final TextEditingController name =
      TextEditingController(text: widget.phase.name);

  late final TextEditingController description =
      TextEditingController(text: widget.phase.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.v8,
      padding: AppPadding.a16,
      decoration: context.defaultBox,
      child: Column(
        children: [
          Text(
            'Phase ${widget.index + 1}',
            style: AppTextStyle.f16B,
          ),
          AppSpacing.h16,
          TextInputValidator(
            controller: name,
            label: 'Name',
            onChanged: (p0) => widget.phase.name = p0,
            validator: (value) => TextValidate.validateEmpty(value,
                errorText: 'Name cannot be empty'),
          ),
          AppSpacing.h16,
          TextInputValidator(
            controller: description,
            onChanged: (p0) => widget.phase.description = p0,
            label: 'Description',
            validator: (value) => TextValidate.validateEmpty(value,
                errorText: 'Description cannot be empty'),
          ),
          AppSpacing.h16,
          Button(
            width: double.maxFinite,
            onPressed: widget.onRemoved,
            child: const Text('Remove phase'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }
}
