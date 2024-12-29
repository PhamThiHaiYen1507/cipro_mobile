import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/custom_tooltip/custom_tooltip.dart';
import 'package:base_project/layers/presentation/widgets/project_workflow_list_builder/project_workflow_list_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:flutter/material.dart';

import 'guide/guide.dart';

class DashboardScriptScreen extends StatefulWidget {
  final String projectName;

  const DashboardScriptScreen({super.key, required this.projectName});

  @override
  State<DashboardScriptScreen> createState() => _DashboardScriptScreenState();
}

class _DashboardScriptScreenState extends State<DashboardScriptScreen> {
  final CustomToolTipController toolTipController = CustomToolTipController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: AppPadding.h16,
            child: CustomToolTip(
              barrierDismissible: true,
              controller: toolTipController,
              tooltip: Container(
                decoration: context.defaultBox,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.sonar.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('Sonar Cloud Integration Guide'),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.trivy.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('Trivy Integration Guide'),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          ScripGuideScreenRoute(type: GuideType.owasp.name)
                              .push(context)
                              .then((value) => toolTipController.close()),
                      child: const Padding(
                        padding: AppPadding.a8,
                        child: Text('OWASP Integration Guide'),
                      ),
                    ),
                  ],
                ),
              ),
              direction: TooltipDirection.bottom,
              tooltipBottomStart: TooltipBottomStart.right,
              child: IconButton(
                onPressed: toolTipController.toggle,
                icon: const Icon(Icons.settings_suggest_sharp),
              ),
            ),
          ),
        ),
        Expanded(
          child: ProjectWorkflowListBuilder(
              projectName: widget.projectName,
              builder: (workflows) {
                if (workflows.isEmpty) {
                  return const Center(
                      child: Text('Found no workflow in this project.'));
                }

                return ListView.separated(
                  padding: AppPadding.a16,
                  separatorBuilder: (context, index) => AppSpacing.h16,
                  itemCount: workflows.length,
                  itemBuilder: (context, i) {
                    final workflow = workflows[i];

                    return Container(
                      padding: AppPadding.a16,
                      decoration: context.defaultBox,
                      child: Text(workflow.content),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
