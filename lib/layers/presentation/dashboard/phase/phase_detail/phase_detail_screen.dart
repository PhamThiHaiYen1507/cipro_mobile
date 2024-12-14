import 'package:base_project/core/extensions/build_context_extension.dart';
import 'package:base_project/core/extensions/color_extension.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/dashboard/phase/phase_builder/phase_builder.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_artifact_button/create_artifact_button.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_task_button/create_task_button.dart';
import 'package:base_project/layers/presentation/dashboard/widgets/create_threat_button/create_threat_button.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:base_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee_widget/text_marquee_widget.dart';

import '../../widgets/add_task_phase_button/add_task_phase_button.dart';
import 'artifact_item/artifact_item.dart';

class PhaseDetailScreen extends StatelessWidget {
  final String projectName;

  final String phaseId;

  const PhaseDetailScreen(
      {super.key, required this.phaseId, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return PhaseBuilder(
      phaseId: phaseId,
      builder: (c, phase) {
        if (phase == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final completedTasks = phase.tasks
            .where((element) => element.status == 'completed')
            .toList();

        final activeTasks = phase.tasks
            .where((element) => element.status != 'completed')
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(phase.name ?? ''),
            centerTitle: true,
          ),
          body: ListView(
            padding: AppPadding.a16,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: AppPadding.a16,
                      decoration: context.defaultBox,
                      child: Column(
                        children: [
                          TextMarqueeWidget(
                            child: Text(
                              'Active tasks'.toUpperCase(),
                              style: AppTextStyle.f16B,
                            ),
                          ),
                          Text(
                            Utils.formatNumber(activeTasks.length),
                            style: AppTextStyle.f32B,
                          )
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.a16,
                  Expanded(
                    child: Container(
                      padding: AppPadding.a16,
                      decoration: context.defaultBox,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: TextMarqueeWidget(
                              child: Text(
                                'Completed tasks'.toUpperCase(),
                                style: AppTextStyle.f16B,
                              ),
                            ),
                          ),
                          Text(
                            Utils.formatNumber(completedTasks.length),
                            style: AppTextStyle.f32B,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.h16,
              Container(
                padding: AppPadding.a16,
                decoration: context.defaultBox,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMarqueeWidget(
                      child: Text(
                        'Progress'.toUpperCase(),
                        style: AppTextStyle.f16B,
                      ),
                    ),
                    AppSpacing.h8,
                    Container(
                      color: AppColors.primaryColor.o(0.4),
                      child: Row(
                        children: [
                          Expanded(
                              flex: completedTasks.length,
                              child: Container(
                                height: 8,
                                color: AppColors.primaryColor,
                              )),
                          Expanded(
                            flex: activeTasks.length,
                            child: Container(
                              height: 8,
                              color: Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    )
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
                    const TextMarqueeWidget(
                      child: Text(
                        'List of tasks in this phase',
                        style: AppTextStyle.f16B,
                      ),
                    ),
                    AppSpacing.h16,
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        const Expanded(child: Text('Name')),
                        const Expanded(child: Text('Status')),
                        const Expanded(child: Text('Description')),
                      ],
                    ),
                    ...phase.tasks.map(
                      (e) {
                        return Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Expanded(child: Text(e.name ?? '')),
                            Expanded(child: Text(e.status ?? '')),
                            Expanded(
                              child: TextMarqueeWidget(
                                child: Text(e.description ?? ''),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    AppSpacing.h32,
                    CreateTaskButton(
                      projectName: projectName,
                      onCreateSuccess: () {},
                    ),
                    AppSpacing.h16,
                    AddTaskPhaseButton(
                      projectName: projectName,
                      phaseId: phaseId,
                      onAddSuccess: c.getPhase,
                    ),
                    AppSpacing.h16,
                    Button(
                      padding: AppPadding.a8,
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove, color: Colors.white),
                          Text('Remove selected tasks'),
                        ],
                      ),
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
                    const TextMarqueeWidget(
                      child: Text(
                        'Artifacts',
                        style: AppTextStyle.f16B,
                      ),
                    ),
                    SizedBox(
                      height: 144,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: phase.artifacts.length,
                        itemBuilder: (context, index) {
                          final artifact = phase.artifacts[index];

                          return ArtifactItem(
                            artifact: artifact,
                            phaseId: phaseId,
                            onDeleteSuccess: c.getPhase,
                            onUpdateSuccess: c.getPhase,
                          );
                        },
                      ),
                    ),
                    AppSpacing.h32,
                    CreateArtifactButton(
                      phaseId: phaseId,
                      onCreateSuccess: c.getPhase,
                    ),
                    AppSpacing.h16,
                    const CreateThreatButton(),
                    AppSpacing.h16,
                    Button(
                      padding: AppPadding.a8,
                      onPressed: () {},
                      backgroundColor: Colors.cyan,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bug_report, color: Colors.white),
                          Text('Threat dictionary'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
