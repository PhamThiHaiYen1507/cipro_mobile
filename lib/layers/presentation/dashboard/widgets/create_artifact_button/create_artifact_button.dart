import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'create_artifact_button_controller.dart';

class CreateArtifactButton
    extends MobxStatefulWidget<CreateArtifactButtonController> {
  final String phaseId;

  final VoidCallback? onCreateSuccess;

  const CreateArtifactButton({
    super.key,
    required this.phaseId,
    this.onCreateSuccess,
  });

  @override
  _CreateArtifactButtonState createState() => _CreateArtifactButtonState();
}

class _CreateArtifactButtonState
    extends MobxState<CreateArtifactButton, CreateArtifactButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: showCreateArtifactForm,
      backgroundColor: AppColors.primaryColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white),
          Text('Add a new artifact'),
        ],
      ),
    );
  }

  void showCreateArtifactForm() {
    AppDialog.dialog(
      context: context,
      insetPadding: AppPadding.a16,
      title: 'Add a new artifact',
      content: CreateArtifactForm(
        onCancel: context.pop,
        onCreate: (name, url, version, cpe, type) async {
          final res = await controller.createArtifact(
              phaseId: widget.phaseId,
              name: name,
              url: url,
              version: version,
              cpe: cpe,
              type: type);

          context.pop();

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Create artifact success',
              type: NotificationType.success,
            );
            widget.onCreateSuccess?.call();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Create artifact failed',
              type: NotificationType.error,
            );
          }
        },
      ),
    );
  }
}

class CreateArtifactForm extends StatefulWidget {
  final VoidCallback onCancel;

  final String? name;

  final String? url;

  final String? version;

  final String? cpe;

  final bool isUpdate;

  final void Function(
          String name, String url, String version, String cpe, String type)
      onCreate;

  const CreateArtifactForm({
    super.key,
    required this.onCancel,
    required this.onCreate,
    this.name,
    this.url,
    this.version,
    this.cpe,
    this.isUpdate = false,
  });

  @override
  State<CreateArtifactForm> createState() => _CreateArtifactFormState();
}

const artifactTypes = [
  'image',
  'log',
  'source code',
  'executable',
  'library',
];

class _CreateArtifactFormState extends State<CreateArtifactForm> {
  late final TextEditingController name =
      TextEditingController(text: widget.name);

  late final TextEditingController url =
      TextEditingController(text: widget.url);

  late final TextEditingController version =
      TextEditingController(text: widget.version);

  late final TextEditingController cpe =
      TextEditingController(text: widget.cpe);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedType = 'image';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInputValidator(
                controller: name,
                label: 'Name',
                validator: (value) => TextValidate.validateEmpty(value,
                    errorText: 'Name cannot be empty'),
              ),
              TextInputValidator(
                controller: url,
                label: 'URL',
                validator: (value) => TextValidate.validateEmpty(value,
                    errorText: 'URL cannot be empty'),
              ),
              TextInputValidator(
                controller: version,
                label: 'Version',
                validator: (value) => TextValidate.validateEmpty(value,
                    errorText: 'Version cannot be empty'),
              ),
              TextInputValidator(
                controller: cpe,
                label: 'Cpe string',
                hintText:
                    'Hint: You can autofill name and version of the artifact by filling in the CPE string. Example of CPE string: cpe:2.3:a:apache:tomcat:3.0:*:*:*:*:*:*:* ',
              ),
              const Text('Type', style: AppTextStyle.f14B),
              IgnorePointer(
                ignoring: widget.isUpdate,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: artifactTypes
                      .map((e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: e,
                                groupValue: selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value!;
                                  });
                                },
                              ),
                              Text(e),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Text(
                'After creating artifact, vulnerabilities will be automatically discovered and added to it.',
                style: AppTextStyle.f16R.copyWith(color: Colors.cyan),
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
                  Expanded(
                    child: Button(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          widget.onCreate(
                            name.text,
                            url.text,
                            version.text,
                            cpe.text,
                            selectedType,
                          );
                        }
                      },
                      child: Text(widget.isUpdate ? 'Update' : 'Create'),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    url.dispose();
    version.dispose();
    cpe.dispose();
    super.dispose();
  }
}
