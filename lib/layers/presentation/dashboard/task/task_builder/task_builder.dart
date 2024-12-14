import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/task_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'task_builder_controller.dart';

class TaskBuilder extends MobxStatefulWidget<TaskBuilderController> {
  final String projectName;

  final String? filter;

  final Widget Function(List<TaskInfoModel> tasks) builder;

  const TaskBuilder({
    super.key,
    required this.projectName,
    this.filter,
    required this.builder,
  }) : super(tag: projectName);

  @override
  _TaskBuilderState createState() => _TaskBuilderState();

  @override
  TaskBuilderController? createController() =>
      TaskBuilderController(injector(), projectName, filter);
}

class _TaskBuilderState extends MobxState<TaskBuilder, TaskBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => widget.builder(controller.tasks));
  }
}
