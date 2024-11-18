import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_activity_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_activity_builder_controller.dart';

class ProjectActivityBuilder
    extends MobxStatefulWidget<ProjectActivityBuilderController> {
  final String? projectName;

  final String? username;

  final Widget Function(List<ProjectActivityInfoModel> activities) builder;

  const ProjectActivityBuilder({
    super.key,
    this.projectName,
    this.username,
    required this.builder,
  }) : super(tag: projectName);

  @override
  ProjectActivityBuilderController createController() =>
      ProjectActivityBuilderController(injector(), projectName ?? '', username);

  @override
  _ProjectActivityBuilderState createState() => _ProjectActivityBuilderState();
}

class _ProjectActivityBuilderState extends MobxState<ProjectActivityBuilder,
    ProjectActivityBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller.activities),
    );
  }
}
