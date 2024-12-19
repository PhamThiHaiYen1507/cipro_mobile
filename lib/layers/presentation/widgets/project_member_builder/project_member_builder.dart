import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_member_builder_controller.dart';

class ProjectMemberBuilder
    extends MobxStatefulWidget<ProjectMemberBuilderController> {
  final String? projectName;

  final Widget Function(ProjectMemberBuilderController controller,
      List<ProjectMemberInfoModel> members) builder;

  const ProjectMemberBuilder({
    super.key,
    this.projectName,
    required this.builder,
  }) : super(tag: projectName);

  @override
  ProjectMemberBuilderController createController() =>
      ProjectMemberBuilderController(injector(), projectName ?? '');

  @override
  MobxState<MobxStatefulWidget<ProjectMemberBuilderController>,
          ProjectMemberBuilderController>
      createState() => _ProjectMemberBuilderState();
}

class _ProjectMemberBuilderState
    extends MobxState<ProjectMemberBuilder, ProjectMemberBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => widget.builder(controller, controller.members));
  }
}
