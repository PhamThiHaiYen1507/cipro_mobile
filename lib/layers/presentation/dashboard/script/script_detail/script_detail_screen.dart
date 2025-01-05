import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/layers/presentation/widgets/project_builder/project_builder.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../widgets/project_workflow_list_builder/project_workflow_list_builder.dart';

class ScriptDetailScreen extends StatelessWidget {
  final String workflowId;

  final String projectName;

  const ScriptDetailScreen(
      {super.key, required this.workflowId, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return ProjectWorkflowListBuilder(
        projectName: projectName,
        builder: (workflows) {
          return ProjectBuilder(
              projectName: projectName,
              builder: (_, project) {
                final info = project?.workflows
                    .firstWhereOrNull((element) => element.id == workflowId);

                final script = workflows
                    .firstWhereOrNull((element) => element.path == info!.path);

                if (info == null) return const Scaffold();

                return Scaffold(
                  appBar: AppBar(
                    title: Text(info.name),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: AppPadding.a16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: AppPadding.a16,
                            decoration: context.defaultBox,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Script', style: AppTextStyle.f18B),
                                AppSpacing.h16,
                                if (script != null)
                                  Text(script.content)
                                else
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ),
                          ),
                          AppSpacing.h16,
                          Container(
                            padding: AppPadding.a16,
                            decoration: context.defaultBox,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Workflow runs history',
                                  style: AppTextStyle.f18B,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: info.runs.map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (e.conclusion == 'success')
                                                const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                )
                                              else
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 2),
                                                    width: 20,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 18,
                                                    )),
                                              AppSpacing.a16,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.displayTitle ?? '',
                                                      style: AppTextStyle.f14B,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.alarm_sharp,
                                                          size: 18,
                                                        ),
                                                        AppSpacing.w4,
                                                        Text(
                                                          Utils
                                                              .formatDateToDisplay(
                                                            e.createdAt,
                                                            'dd/MM/yyyy HH:mm:ss',
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
