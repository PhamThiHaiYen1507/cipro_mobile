import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_phase_template_button/create_phase_template_button.dart';
import 'package:base_project/layers/presentation/widgets/grid_table/grid_table.dart';
import 'package:base_project/utils/app_dialog/app_dialog.dart';
import 'package:base_project/utils/enum/notification_type.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../../core/state_manager/mobx_manager.dart';
import '../../../domain/entities/phase_template_model.dart';
import '../../widgets/phase_template_builder/phase_template_builder.dart';
import 'dashboard_template_controller.dart';

class DashboardTemplateScreen
    extends MobxStatefulWidget<DashboardTemplateController> {
  const DashboardTemplateScreen({super.key});

  @override
  _DashboardTemplateScreenState createState() =>
      _DashboardTemplateScreenState();
}

class _DashboardTemplateScreenState
    extends MobxState<DashboardTemplateScreen, DashboardTemplateController> {
  @override
  Widget build(BuildContext context) {
    return PhaseTemplateBuilder(builder: (c, templates) {
      final List<GridTableColumnConfig<PhaseTemplateModel>> configs = [
        GridTableColumnConfig(
          columnWidth: const TableSpan(extent: FixedSpanExtent(220)),
          headerBuilder: (context) {
            return Container(
              color: AppColors.greyColor.o(0.2),
              alignment: Alignment.centerLeft,
              padding: AppPadding.h16,
              child: Text('Name'.toUpperCase()),
            );
          },
          cellBuilder: (context, data, index) => Container(
            padding: AppPadding.h16,
            child: TextMarqueeWidget(
              child: Text(data.name),
            ),
          ),
        ),
        GridTableColumnConfig(
          columnWidth: const TableSpan(extent: FixedSpanExtent(180)),
          headerBuilder: (context) {
            return Container(
              color: AppColors.greyColor.o(0.2),
              alignment: Alignment.centerLeft,
              child: Text('Description'.toUpperCase()),
            );
          },
          cellBuilder: (context, data, index) => Align(
              alignment: Alignment.centerLeft,
              child: TextMarqueeWidget(child: Text(data.description))),
        ),
        GridTableColumnConfig(
          columnWidth: const TableSpan(extent: FixedSpanExtent(120)),
          headerBuilder: (context) {
            return Container(
              color: AppColors.greyColor.o(0.2),
              alignment: Alignment.centerLeft,
              child: Text('Created by'.toUpperCase()),
            );
          },
          cellBuilder: (context, data, index) => Align(
              alignment: Alignment.centerLeft,
              child: TextMarqueeWidget(child: Text(data.createdBy))),
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
          cellBuilder: (context, data, index) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreatePhaseTemplateButton(
                onCreateSuccess: () => c.fetchTemplateList(),
                template: data,
                child: const Padding(
                  padding: AppPadding.a8,
                  child: Icon(Icons.more_horiz),
                ),
              ),
              IconButton(
                onPressed: () => showDeletePopup(data.id)
                    .then((value) => c.fetchTemplateList()),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CreatePhaseTemplateButton(
              onCreateSuccess: () => c.fetchTemplateList(),
              child: Padding(
                padding: AppPadding.a16,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.add, color: AppColors.primaryColor),
                  Text(
                    'Add new template',
                    style: AppTextStyle.f14B
                        .copyWith(color: AppColors.primaryColor),
                  )
                ]),
              )),
          Expanded(
            child: GridTable<PhaseTemplateModel>(
              items: templates,
              configs: configs,
            ),
          ),
        ],
      );
    });
  }

  Future<void> showDeletePopup(String templateId) async {
    await AppDialog.dialog(
      context: context,
      title: 'Delete template',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Are you sure you want to delete this phase template?'),
          AppSpacing.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                backgroundColor: AppColors.midGrey,
                onPressed: () => context.pop(),
                child: const Text('Cancel', style: AppTextStyle.f16B),
              ),
              AppSpacing.w16,
              Button(
                onPressed: () async {
                  final res =
                      await controller.onDeletePhaseTemplate(templateId);

                  context.pop();

                  if (res) {
                    AppDialog.showNotification(
                      context: context,
                      message: 'Delete template success',
                      type: NotificationType.success,
                    );
                  } else {
                    AppDialog.showNotification(
                      context: context,
                      message: 'Delete template failed',
                      type: NotificationType.error,
                    );
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
