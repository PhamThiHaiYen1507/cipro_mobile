import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/project_member_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'project_member_info_builder_controller.dart';

class ProjectMemberInfoBuilder
    extends MobxStatefulWidget<ProjectMemberInfoBuilderController> {
  final String? memberId;

  final String? accountId;

  final Widget Function(ProjectMemberInfoBuilderController controller,
      ProjectMemberInfoModel? member) builder;

  const ProjectMemberInfoBuilder({
    super.key,
    this.memberId,
    this.accountId,
    required this.builder,
  }) : super(tag: memberId ?? accountId);

  @override
  ProjectMemberInfoBuilderController createController() =>
      ProjectMemberInfoBuilderController(injector(), memberId, accountId);

  @override
  _ProjectMemberInfoBuilderState createState() =>
      _ProjectMemberInfoBuilderState();
}

class _ProjectMemberInfoBuilderState extends MobxState<ProjectMemberInfoBuilder,
    ProjectMemberInfoBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.builder(controller, controller.member),
    );
  }
}
