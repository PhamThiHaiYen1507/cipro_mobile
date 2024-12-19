import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/core/global/account_manager_controller.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:base_project/layers/domain/entities/vulnerability_model.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/artifact_builder/artifact_builder.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/layers/presentation/widgets/project_member_builder/project_member_builder.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_border_radius.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'create_ticket_button_controller.dart';

class CreateTicketButton
    extends MobxStatefulWidget<CreateTicketButtonController> {
  final String projectName;

  final VoidCallback? onCreateSuccess;

  const CreateTicketButton(
      {super.key, this.onCreateSuccess, required this.projectName});

  @override
  _CreateTicketButtonState createState() => _CreateTicketButtonState();
}

class _CreateTicketButtonState
    extends MobxState<CreateTicketButton, CreateTicketButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: showCreateTicketForm,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white),
          Text('Create a new ticket'),
        ],
      ),
    );
  }

  void showCreateTicketForm() {
    AppDialog.dialog(
      context: context,
      title: 'Create a new ticket',
      insetPadding: AppPadding.a16,
      content: CreateTicketForm(
        onCancel: context.pop,
        projectName: widget.projectName,
        onCreate: (assigneeId, description, priority, projectName,
            targetedVulnerability, title) async {
          context.pop();

          final res = await controller.onCreateTicket(
            assigneeId: assigneeId,
            description: description,
            priority: priority,
            projectName: projectName,
            targetedVulnerability: targetedVulnerability,
            title: title,
          );

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Create ticket success',
              type: NotificationType.success,
            );
            widget.onCreateSuccess?.call();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Create ticket failed',
              type: NotificationType.error,
            );
          }
        },
      ),
    );
  }
}

class CreateTicketForm extends StatefulWidget {
  final VoidCallback onCancel;

  final String projectName;

  final void Function(
      String? assigneeId,
      String? description,
      String? priority,
      String? projectName,
      List<VulnerabilityModel> targetedVulnerability,
      String? title) onCreate;

  const CreateTicketForm(
      {super.key,
      required this.onCancel,
      required this.onCreate,
      required this.projectName});

  @override
  State<CreateTicketForm> createState() => _CreateTicketFormState();
}

class _CreateTicketFormState extends State<CreateTicketForm> {
  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProjectMemberInfoModel? selectedAssignee;

  String selectedPriority = 'Low';

  final List<VulnerabilityModel> selectedVuls = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextInputValidator(
            controller: title,
            label: 'Title',
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
          Row(children: [
            const Text('Priority', style: AppTextStyle.f14B),
            ...['Low', 'Medium', 'High'].map(
              (e) => Row(
                children: [
                  Radio(
                    value: e,
                    groupValue: selectedPriority,
                    onChanged: (value) => setState(() {
                      selectedPriority = value!;
                    }),
                  ),
                  Text(e),
                ],
              ),
            )
          ]),
          MobxBuilder<AccountManagerController>(
            builder: (controller) => TextInputValidator(
              initialText: controller.accountInfo?.username,
              enabled: false,
              label: 'Assigner',
            ),
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
              itemBuilder: (item) => Padding(
                padding: AppPadding.a8,
                child: Text(
                  item.name ?? '',
                ),
              ),
              selectedItem: selectedAssignee,
              onSelected: (item) => setState(() {
                selectedAssignee = item;
              }),
            ),
          ),
          AppSpacing.h16,
          ArtifactBuilder(
            projectName: widget.projectName,
            builder: (artifacts) {
              final vulns = artifacts.fold<List<VulnerabilityModel>>(
                  [],
                  (previousValue, element) =>
                      [...previousValue, ...element.vulnerabilityList]);

              return CustomDropdown<VulnerabilityModel>(
                items: vulns,
                fitSize: true,
                placeHolderBuilder: () => Padding(
                  padding: AppPadding.h8,
                  child: Text(
                    'Vulnerability',
                    style: AppTextStyle.f16R.copyWith(color: Colors.grey),
                  ),
                ),
                itemBuilder: (item) => Padding(
                  padding: AppPadding.a8,
                  child: Text(
                    item.cveId ?? '',
                  ),
                ),
                selectedItem: selectedVuls.firstOrNull,
                onSelected: (item) => setState(() {
                  if (!selectedVuls.map((e) => e.id).contains(item.id)) {
                    selectedVuls.add(item);
                  }
                }),
                useExpand: true,
                selectedBuilder: (_) => SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: selectedVuls
                        .map((e) => Container(
                              alignment: Alignment.center,
                              margin: AppPadding.a4,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.o(0.2),
                                borderRadius: AppBorderRadius.sm,
                              ),
                              child: Row(
                                children: [
                                  AppSpacing.w8,
                                  Text(e.cveId ?? ''),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        selectedVuls.remove(e);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            },
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
                        selectedAssignee?.memberId,
                        description.text,
                        selectedPriority.toLowerCase(),
                        widget.projectName,
                        selectedVuls,
                        title.text,
                      );
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }
}
