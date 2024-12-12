import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/artifact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'artifact_builder_controller.dart';

class ArtifactBuilder extends MobxStatefulWidget<ArtifactBuilderController> {
  final String projectName;

  final Widget Function(List<ArtifactModel> artifacts) builder;

  const ArtifactBuilder({
    super.key,
    required this.projectName,
    required this.builder,
  });

  @override
  MobxState<MobxStatefulWidget<ArtifactBuilderController>,
      ArtifactBuilderController> createState() => _ArtifactBuilderState();

  @override
  ArtifactBuilderController? createController() =>
      ArtifactBuilderController(injector(), projectName);
}

class _ArtifactBuilderState
    extends MobxState<ArtifactBuilder, ArtifactBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => widget.builder(controller.artifacts));
  }
}
