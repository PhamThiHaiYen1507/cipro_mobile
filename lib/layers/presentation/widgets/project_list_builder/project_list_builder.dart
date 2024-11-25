import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_list_builder_controller.dart';

class ProjectListBuilder
    extends MobxStatefulWidget<ProjectListBuilderController> {
  final Widget Function(List<ProjectInfoModel> projects) builder;

  final void Function(List<ProjectInfoModel> projects)? onInitialize;

  const ProjectListBuilder({
    super.key,
    this.onInitialize,
    required this.builder,
  });

  @override
  _ProjectListBuilderState createState() => _ProjectListBuilderState();

  @override
  ProjectListBuilderController? createController() =>
      ProjectListBuilderController(injector(), onInitialize);
}

class _ProjectListBuilderState
    extends MobxState<ProjectListBuilder, ProjectListBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller.projects),
    );
  }
}
