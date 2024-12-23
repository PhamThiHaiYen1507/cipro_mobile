import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_builder_controller.dart';

class ProjectBuilder extends MobxStatefulWidget<ProjectBuilderController> {
  final String? projectName;

  final Widget Function(
      ProjectBuilderController controller, ProjectInfoModel? project) builder;

  const ProjectBuilder({
    super.key,
    this.projectName,
    required this.builder,
  }) : super(tag: projectName);

  @override
  ProjectBuilderController? createController() =>
      ProjectBuilderController(injector(), projectName);

  @override
  MobxState<MobxStatefulWidget<ProjectBuilderController>,
      ProjectBuilderController> createState() => _ProjectBuilderState();
}

class _ProjectBuilderState
    extends MobxState<ProjectBuilder, ProjectBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => widget.builder(controller, controller.project));
  }
}
