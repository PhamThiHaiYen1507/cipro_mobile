import 'package:base_project/core/di/injector.dart';
import 'package:base_project/layers/domain/entities/resolution_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/state_manager/mobx_manager.dart';
import 'resolution_builder_controller.dart';

class ResolutionBuilder
    extends MobxStatefulWidget<ResolutionBuilderController> {
  final List<String> cveIds;

  final Widget Function(List<ResolutionModel> resolutions) builder;

  const ResolutionBuilder({
    super.key,
    required this.cveIds,
    required this.builder,
  });

  @override
  _ResolutionBuilderState createState() => _ResolutionBuilderState();

  @override
  ResolutionBuilderController? createController() =>
      ResolutionBuilderController(injector(), cveIds);

  @override
  String? get tag => cveIds.join('||');
}

class _ResolutionBuilderState
    extends MobxState<ResolutionBuilder, ResolutionBuilderController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => widget.builder(controller.resolutions));
  }
}
