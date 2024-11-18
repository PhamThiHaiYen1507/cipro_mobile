import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/workflow_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_workflow_list_builder_controller.dart';

class ProjectWorkflowListBuilder
    extends MobxStatefulWidget<ProjectWorkflowListBuilderController> {
  final String projectName;

  final Widget Function(List<WorkflowInfoModel> workflows) builder;

  const ProjectWorkflowListBuilder(
      {super.key, required this.projectName, required this.builder})
      : super(tag: projectName);

  @override
  ProjectWorkflowListBuilderController? createController() =>
      ProjectWorkflowListBuilderController(injector(), projectName);

  @override
  _ProjectWorkflowListBuilderState createState() =>
      _ProjectWorkflowListBuilderState();
}

class _ProjectWorkflowListBuilderState extends MobxState<
    ProjectWorkflowListBuilder, ProjectWorkflowListBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller.workflows),
    );
  }
}
