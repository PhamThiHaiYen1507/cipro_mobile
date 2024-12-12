import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/project_workflow_list_builder/project_workflow_list_builder.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:flutter/material.dart';

class DashboardScriptScreen extends StatelessWidget {
  final String projectName;

  const DashboardScriptScreen({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return ProjectWorkflowListBuilder(
        projectName: projectName,
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
        });
  }
}
