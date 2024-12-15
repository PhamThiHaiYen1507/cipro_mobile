import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/helpers/text_input_validator.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

import 'create_threat_button_controller.dart';

const theatTypes = [
  'Spoofing',
  'Tampering',
  'Repuditation',
  'Information Disclosure',
  'Denial of Service',
  'Elevation of Privilege',
];

class CreateThreatButton
    extends MobxStatefulWidget<CreateThreatButtonController> {
  final VoidCallback? onCreateSuccess;

  const CreateThreatButton({super.key, this.onCreateSuccess});

  @override
  _CreateThreatButtonState createState() => _CreateThreatButtonState();
}

class _CreateThreatButtonState
    extends MobxState<CreateThreatButton, CreateThreatButtonController> {
  @override
  Widget build(BuildContext context) {
    return Button(
      padding: AppPadding.a8,
      onPressed: showCreateThreatForm,
      backgroundColor: Colors.orangeAccent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bug_report, color: Colors.white),
          Text('Add a new threat'),
        ],
      ),
    );
  }

  void showCreateThreatForm() {
    AppDialog.dialog(
      context: context,
      insetPadding: AppPadding.a16,
      content: CreateThreatForm(
        onCancel: context.pop,
        onCreate: (name, description, type, total, damage, reproducibility,
            exploitability, affectedUsers, discoverability) async {
          context.pop();

          final res = await controller.onCreateThreat(
            name: name,
            description: description,
            type: type,
            total: total,
            damage: damage,
            reproducibility: reproducibility,
            exploitability: exploitability,
            affectedUsers: affectedUsers,
            discoverability: discoverability,
          );

          if (res) {
            AppDialog.showNotification(
              context: context,
              message: 'Create threat success',
              type: NotificationType.success,
            );
            widget.onCreateSuccess?.call();
          } else {
            AppDialog.showNotification(
              context: context,
              message: 'Create threat failed',
              type: NotificationType.error,
            );
          }
        },
      ),
      title: 'Create a new task',
    );
  }
}

class CreateThreatForm extends StatefulWidget {
  final VoidCallback onCancel;

  final void Function(
    String name,
    String description,
    String type,
    double total,
    int damage,
    int reproducibility,
    int exploitability,
    int affectedUsers,
    int discoverability,
  ) onCreate;

  const CreateThreatForm(
      {super.key, required this.onCancel, required this.onCreate});

  @override
  State<CreateThreatForm> createState() => _CreateThreatFormState();
}

class _CreateThreatFormState extends State<CreateThreatForm> {
  final TextEditingController name = TextEditingController();

  final TextEditingController description = TextEditingController();

  String selectedType = 'Spoofing';

  final ValueNotifier<double> damage = ValueNotifier(0);

  final ValueNotifier<double> reproducibility = ValueNotifier(0);

  final ValueNotifier<double> exploitability = ValueNotifier(0);

  final ValueNotifier<double> affectedUsers = ValueNotifier(0);

  final ValueNotifier<double> discoverability = ValueNotifier(0);

  final ValueNotifier<double> total = ValueNotifier(0);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: SizedBox(
          width: double.maxFinite,
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
            Row(
              children: [
                const Text('Type: ', style: AppTextStyle.f14B),
                Expanded(
                    child: CustomDropdown(
                  selectedItem: selectedType,
                  items: theatTypes,
                  fitSize: true,
                  itemBuilder: (item) => Padding(
                    padding: AppPadding.a4.add(AppPadding.h4),
                    child: Text(item),
                  ),
                  onSelected: (item) => setState(() => selectedType = item),
                ))
              ],
            ),
            AppSpacing.h16,
            const TextMarqueeWidget(
              child: Text(
                  'Damage: How big would the damage be if the attack succeeded?',
                  style: AppTextStyle.f14B),
            ),
            ValueListenableBuilder(
              valueListenable: damage,
              builder: (context, value, child) => Slider(
                value: value,
                onChanged: (value) {
                  damage.value = value.round().toDouble();
                  calculateTotal();
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            const TextMarqueeWidget(
              child: Text(
                  'Reproducibility: How easy is it to reproduce the attack?',
                  style: AppTextStyle.f14B),
            ),
            ValueListenableBuilder(
              valueListenable: reproducibility,
              builder: (context, value, child) => Slider(
                value: value,
                onChanged: (value) {
                  reproducibility.value = value.round().toDouble();
                  calculateTotal();
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            const TextMarqueeWidget(
              child: Text(
                  'Exploitability: How easy is it to exploit the vulnerability?',
                  style: AppTextStyle.f14B),
            ),
            ValueListenableBuilder(
              valueListenable: exploitability,
              builder: (context, value, child) => Slider(
                value: value,
                onChanged: (value) {
                  exploitability.value = value.round().toDouble();
                  calculateTotal();
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            const TextMarqueeWidget(
              child: Text(
                  'Affected Users: How many users are affected by the vulnerability?',
                  style: AppTextStyle.f14B),
            ),
            ValueListenableBuilder(
              valueListenable: affectedUsers,
              builder: (context, value, child) => Slider(
                value: value,
                onChanged: (value) {
                  affectedUsers.value = value.round().toDouble();
                  calculateTotal();
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            const TextMarqueeWidget(
              child: Text(
                  'Discoverability: How easy is it to discover the vulnerability?',
                  style: AppTextStyle.f14B),
            ),
            ValueListenableBuilder(
              valueListenable: discoverability,
              builder: (context, value, child) => Slider(
                value: value,
                onChanged: (value) {
                  discoverability.value = value.round().toDouble();
                  calculateTotal();
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: total,
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Final score'),
                  Text(
                    Utils.formatNumber(value),
                    style: AppTextStyle.f16B,
                  )
                ],
              ),
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
                AppSpacing.w16,
                Expanded(
                  child: Button(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        widget.onCreate(
                            name.text,
                            description.text,
                            selectedType,
                            total.value,
                            damage.value.round(),
                            reproducibility.value.round(),
                            exploitability.value.round(),
                            affectedUsers.value.round(),
                            discoverability.value.round());
                      }
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void calculateTotal() {
    total.value = ((damage.value +
                reproducibility.value +
                exploitability.value +
                affectedUsers.value +
                discoverability.value) /
            50) *
        10;
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    damage.dispose();
    reproducibility.dispose();
    exploitability.dispose();
    affectedUsers.dispose();
    discoverability.dispose();
    total.dispose();
    super.dispose();
  }
}
